// src/views/js/arbitrios.js
console.log('[ARBITRIOS] Script cargado. readyState:', document.readyState);

if (document.readyState === 'loading') {
  console.log('[ARBITRIOS] DOM aún cargando, esperando DOMContentLoaded...');
  document.addEventListener('DOMContentLoaded', initializeArbitrios);
} else {
  console.log('[ARBITRIOS] DOM ya listo, inicializando directamente...');
  setTimeout(initializeArbitrios, 100);
}

function initializeArbitrios() {
  console.log('[ARBITRIOS] === INICIANDO ARBITRIOS ===');
  
  // Obtener ID del contribuyente de la URL
  const urlParams = new URLSearchParams(window.location.search);
  const idContribuyente = urlParams.get('id');
  console.log('[ARBITRIOS] ID Contribuyente:', idContribuyente);
  
  const btnAgregarPredio = document.getElementById('btnAgregarPredio');
  const btnCerrarModal = document.getElementById('btnCerrarModal');
  const btnCancelarModal = document.getElementById('btnCancelarModal');
  const modalAgregarPredio = document.getElementById('modalAgregarPredio');
  const predioSearch = document.getElementById('predioSearch');
  const predioList = document.getElementById('predioList');
  const formAgregarPredio = document.getElementById('formAgregarPredio');
  
  // Elementos para categorización
  const btnCrearCategorizacion = document.getElementById('btnCrearCategorizacion');
  const btnClonarCategorizacion = document.getElementById('btnClonarCategorizacion');
  const modalCrearCategorizacion = document.getElementById('modalCrearCategorizacion');
  const modalClonarCategorizacion = document.getElementById('modalClonarCategorizacion');
  const formCrearCategorizacion = document.getElementById('formCrearCategorizacion');
  const formClonarCategorizacion = document.getElementById('formClonarCategorizacion');
  
  // Variables globales
  let selectedPredioId = null;
  let selectedPredioData = null;
  
  // ============ SELECTOR DE PREDIOS ============
  const selectAllPredios = document.getElementById('selectAllPredios');
  if (selectAllPredios) {
    selectAllPredios.addEventListener('change', function() {
      const checkboxes = document.querySelectorAll('.predio-checkbox');
      checkboxes.forEach(cb => {
        cb.checked = this.checked;
      });
    });
  }
  
  // Seleccionar predio individual
  document.addEventListener('change', function(e) {
    if (e.target.classList.contains('predio-checkbox')) {
      const predioId = e.target.dataset.predioId;
      const predioRow = e.target.closest('.predio-row');
      
      if (e.target.checked) {
        // Desmarcar otros predios
        document.querySelectorAll('.predio-checkbox').forEach(cb => {
          if (cb !== e.target) cb.checked = false;
        });
        
        // Mostrar sección de categorización
        mostrarCategorizacionPredio(predioId, predioRow);
      } else {
        // Ocultar sección de categorización
        ocultarCategorizacion();
      }
    }
  });

  // ============ FUNCIONES PARA CATEGORIZACIÓN ============
  function mostrarCategorizacionPredio(predioId, predioRow) {
    selectedPredioId = predioId;
    
    // Obtener datos del predio desde la fila
    const cells = predioRow.querySelectorAll('td');
    selectedPredioData = {
      estado: cells[1].textContent.trim(),
      codigo: cells[2].textContent.trim(),
      direccion: cells[3].textContent.trim(),
      referencia: cells[4].textContent.trim()
    };
    
    // Mostrar sección de categorización
    const categorizacionSection = document.getElementById('categorizacionSection');
    const predioInfo = document.getElementById('predioInfo');
    
    if (categorizacionSection && predioInfo) {
      categorizacionSection.style.display = 'block';
      predioInfo.innerHTML = `
        <div class="info-row">
          <div class="info-group">
            <label>Predio:</label>
            <span>${selectedPredioData.codigo} - ${selectedPredioData.direccion}</span>
          </div>
          <div class="info-group">
            <label>Estado:</label>
            <span>${selectedPredioData.estado}</span>
          </div>
          <div class="info-group">
            <label>Referencia:</label>
            <span>${selectedPredioData.referencia}</span>
          </div>
        </div>
      `;
      
      // Cargar categorizaciones del predio
      cargarCategorizacionesPredio(predioId);
    }
  }
  
  function ocultarCategorizacion() {
    selectedPredioId = null;
    selectedPredioData = null;
    
    const categorizacionSection = document.getElementById('categorizacionSection');
    if (categorizacionSection) {
      categorizacionSection.style.display = 'none';
    }
  }
  
// En src/views/js/arbitrios.js
async function cargarCategorizacionesPredio(predioId) {
    const tableBody = document.getElementById('categorizacionesTableBody');
    if (!tableBody) return;
    
    // Mostrar spinner de carga
    tableBody.innerHTML = `
      <tr>
        <td colspan="30" class="text-center loading">
          <i class="fas fa-spinner fa-spin"></i> Cargando categorizaciones...
        </td>
      </tr>
    `;
    
    try {
      // Llamada REAL al controlador PHP (arbitrios.php)
      const response = await fetch(
        `index.php?c=arbitrios&m=getCategorizacionesPredio&id_predio=${predioId}&id_contribuyente=${idContribuyente}`
      );
      const result = await response.json();
      
      if (result.success) {
        // Si el PHP devuelve datos (incluso si es un array vacío []), mostrarlos.
        mostrarCategorizaciones(result.data);
      } else {
        // Si hay un error en el servidor (ej: SQL)
        tableBody.innerHTML = `
          <tr>
            <td colspan="30" class="text-center error">
              <i class="fas fa-exclamation-triangle"></i> Error del servidor: ${result.error}
            </td>
          </tr>
        `;
      }
    } catch (error) {
      // Si hay un error de conexión o parseo JSON
      console.error('[ARBITRIOS] Error al cargar categorizaciones:', error);
      tableBody.innerHTML = `
        <tr>
          <td colspan="30" class="text-center error">
            <i class="fas fa-exclamation-triangle"></i> Error al conectar con el servidor
          </td>
        </tr>
      `;
    }
}


function mostrarCategorizaciones(categorizaciones) {
    const tableBody = document.getElementById('categorizacionesTableBody');
    if (!tableBody) return;
    
    if (categorizaciones.length === 0) {
        tableBody.innerHTML = `
            <tr>
                <td colspan="30" class="text-center">
                    <i class="fas fa-inbox"></i> No hay categorizaciones registradas
                </td>
            </tr>
        `;
        return;
    }
    
    let html = '';
    
    categorizaciones.forEach((cat, index) => {
        // Función para mostrar meses
        const getMesClass = (mes) => mes == 1 ? 'mes-activo' : 'mes-inactivo';
        const getMesText = (mes) => mes == 1 ? '✓' : '✗';
        
        html += `
            <tr>
                <td class="categorizacion-actions">
                    <button class="btn-ver-cat" title="Ver" data-id="${cat.id_arbitrio_detalle}">
                        <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-editar-cat" title="Editar" data-id="${cat.id_arbitrio_detalle}">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-eliminar-cat" title="Eliminar" data-id="${cat.id_arbitrio_detalle}">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
                <td>${cat.anio || ''}</td>
                <td>${cat.item || ''}</td>
                <td class="${getMesClass(cat.enero)}">${getMesText(cat.enero)}</td>
                <td class="${getMesClass(cat.febrero)}">${getMesText(cat.febrero)}</td>
                <td class="${getMesClass(cat.marzo)}">${getMesText(cat.marzo)}</td>
                <td class="${getMesClass(cat.abril)}">${getMesText(cat.abril)}</td>
                <td class="${getMesClass(cat.mayo)}">${getMesText(cat.mayo)}</td>
                <td class="${getMesClass(cat.junio)}">${getMesText(cat.junio)}</td>
                <td class="${getMesClass(cat.julio)}">${getMesText(cat.julio)}</td>
                <td class="${getMesClass(cat.agosto)}">${getMesText(cat.agosto)}</td>
                <td class="${getMesClass(cat.septiembre)}">${getMesText(cat.septiembre)}</td>
                <td class="${getMesClass(cat.octubre)}">${getMesText(cat.octubre)}</td>
                <td class="${getMesClass(cat.noviembre)}">${getMesText(cat.noviembre)}</td>
                <td class="${getMesClass(cat.diciembre)}">${getMesText(cat.diciembre)}</td>
                <td>${cat.categoria_limpieza || 'N/A'}</td>
                <td>${cat.categoria_parques || 'N/A'}</td>
                <td>${cat.categoria_residuos || 'N/A'}</td>
                <td>${cat.categoria_serenazgo || 'N/A'}</td>
                <td>${cat.exoneracion_limpieza || 'Afecto al arbitrio'}</td>
                <td>${cat.exoneracion_parques || 'Afecto al arbitrio'}</td>
                <td>${cat.exoneracion_residuos || 'Afecto al arbitrio'}</td>
                <td>${cat.exoneracion_serenazgo || 'Afecto al arbitrio'}</td>
                <td>S/. ${parseFloat(cat.monto_base || 0).toFixed(2)}</td>
                <td>S/. ${parseFloat(cat.interes || 0).toFixed(2)}</td>
                <td>S/. ${parseFloat(cat.mora || 0).toFixed(2)}</td>
                <td>S/. ${parseFloat(cat.monto_final || 0).toFixed(2)}</td>
                <td>${cat.usuario_actualizado || 'Sistema'}</td>
                <td>${cat.fecha_actualizado || ''}</td>
            </tr>
        `;
    });
    
    tableBody.innerHTML = html;
    
    // Agregar eventos a los botones de acciones
    agregarEventosCategorizaciones();
}
  
  function agregarEventosCategorizaciones() {
    // Botones de eliminar
    const btnEliminarCat = document.querySelectorAll('.btn-eliminar-cat');
    btnEliminarCat.forEach(btn => {
      btn.addEventListener('click', async function() {
        const idDetalle = this.dataset.id;
        if (confirm('¿Está seguro de eliminar esta categorización?')) {
          try {
            const response = await fetch(
              `index.php?c=arbitrios&m=eliminarCategorizacion&id_detalle=${idDetalle}`
            );
            const result = await response.json();
            
            if (result.success) {
              alert('Categorización eliminada correctamente');
              cargarCategorizacionesPredio(selectedPredioId);
            } else {
              alert('Error: ' + result.error);
            }
          } catch (error) {
            console.error('[ARBITRIOS] Error al eliminar categorización:', error);
            alert('Error al conectar con el servidor');
          }
        }
      });
    });
    
    // Botones de clonar (preparar datos)
    const btnEditarCat = document.querySelectorAll('.btn-editar-cat');
    btnEditarCat.forEach(btn => {
      btn.addEventListener('click', function() {
        const idDetalle = this.dataset.id;
        document.getElementById('clonarIdDetalle').value = idDetalle;
        modalClonarCategorizacion.classList.add('active');
      });
    });
  }
  
  // ============ MODALES DE CATEGORIZACIÓN ============
  if (btnCrearCategorizacion && modalCrearCategorizacion) {
    btnCrearCategorizacion.addEventListener('click', function() {
      if (!selectedPredioId) {
        alert('Por favor, seleccione un predio primero');
        return;
      }
      
      // Llenar datos del predio en el modal
      document.getElementById('catContribuyente').textContent = 
        document.querySelector('.arb-value:nth-child(2)')?.textContent || '';
      document.getElementById('catDireccion').textContent = selectedPredioData.direccion;
      document.getElementById('catReferencia').textContent = selectedPredioData.referencia;
      
      modalCrearCategorizacion.classList.add('active');
    });
  }
  
  if (btnClonarCategorizacion && modalClonarCategorizacion) {
    btnClonarCategorizacion.addEventListener('click', function() {
      if (!selectedPredioId) {
        alert('Por favor, seleccione un predio primero');
        return;
      }
      
      // Verificar que haya categorizaciones para clonar
      const hasCategorizaciones = document.querySelectorAll('#categorizacionesTableBody tr').length > 1;
      if (!hasCategorizaciones) {
        alert('No hay categorizaciones para clonar');
        return;
      }
      
      modalClonarCategorizacion.classList.add('active');
    });
  }
  
  // Cerrar modales de categorización
  const btnCerrarCrearCat = document.getElementById('btnCerrarCrearCat');
  const btnCancelarCrearCat = document.getElementById('btnCancelarCrearCat');
  const btnCerrarClonarCat = document.getElementById('btnCerrarClonarCat');
  const btnCancelarClonarCat = document.getElementById('btnCancelarClonarCat');
  
  if (btnCerrarCrearCat) {
    btnCerrarCrearCat.addEventListener('click', () => {
      modalCrearCategorizacion.classList.remove('active');
    });
  }
  
  if (btnCancelarCrearCat) {
    btnCancelarCrearCat.addEventListener('click', () => {
      modalCrearCategorizacion.classList.remove('active');
    });
  }
  
  if (btnCerrarClonarCat) {
    btnCerrarClonarCat.addEventListener('click', () => {
      modalClonarCategorizacion.classList.remove('active');
    });
  }
  
  if (btnCancelarClonarCat) {
    btnCancelarClonarCat.addEventListener('click', () => {
      modalClonarCategorizacion.classList.remove('active');
    });
  }
  
// Formulario de crear categorización - ACTUALIZADO
// Formulario de crear categorización - CON VALORES FIJOS PARA PRUEBA
if (formCrearCategorizacion) {
    formCrearCategorizacion.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        if (!selectedPredioId) {
            alert('Error: No hay predio seleccionado');
            return;
        }
        
        const formData = new FormData(this);
        
        // Función para convertir checkbox a 1/0
        const checkboxToInt = (value) => value === 'on' ? 1 : 0;
        
        // VALORES FIJOS PARA PRUEBA - usa IDs que existan en tu tabla tipo_beneficio
        const data = {
            id_contribuyente: idContribuyente,
            id_predio: selectedPredioId,
            anio: parseInt(formData.get('anio')) || 2024,
            item: parseInt(formData.get('item')) || 1,
            frentera_metros: parseFloat(formData.get('frentera_metros')) || 0,
            frecuencia_barrido: parseInt(formData.get('frecuencia_barrido')) || 1,
            nro_habitantes: parseInt(formData.get('nro_habitantes')) || 1,
            area_construida: parseFloat(formData.get('area_construida')) || 0,
            area_terreno: parseFloat(formData.get('area_terreno')) || 0,
            distancia_a_parque: parseFloat(formData.get('distancia_a_parque')) || 1000,
            tiene_licencia: 0,
            porcentaje_inseguridad: 0,
            // Meses
            enero: checkboxToInt(formData.get('enero')),
            febrero: checkboxToInt(formData.get('febrero')),
            marzo: checkboxToInt(formData.get('marzo')),
            abril: checkboxToInt(formData.get('abril')),
            mayo: checkboxToInt(formData.get('mayo')),
            junio: checkboxToInt(formData.get('junio')),
            julio: checkboxToInt(formData.get('julio')),
            agosto: checkboxToInt(formData.get('agosto')),
            septiembre: checkboxToInt(formData.get('septiembre')),
            octubre: checkboxToInt(formData.get('octubre')),
            noviembre: checkboxToInt(formData.get('noviembre')),
            diciembre: checkboxToInt(formData.get('diciembre')),
            // Categorías - VALORES FIJOS (ajusta según tus IDs reales)
            id_tipo_beneficio_limpieza_publica: 1, // Prueba con ID 1
            id_tipo_beneficio_parques_jardines: 2, // Prueba con ID 2
            id_tipo_beneficio_relleno_sanitario: 3, // Prueba con ID 3
            id_tipo_beneficio_serenazgo: 4, // Prueba con ID 4
            // Exoneraciones - VALORES FIJOS (ajusta según tus IDs reales)
            exoneracion_limpieza_publica: 5, // Prueba con ID 5
            exoneracion_parques_jardines: 6, // Prueba con ID 6
            exoneracion_relleno_sanitario: 7, // Prueba con ID 7
            exoneracion_serenazgo: 8 // Prueba con ID 8
        };
        
        console.log('[ARBITRIOS] Datos a enviar (CON VALORES FIJOS):', data);
        
        try {
            const response = await fetch('index.php?c=arbitrios&m=crearCategorizacion', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            });
            
            const result = await response.json();
            console.log('[ARBITRIOS] Respuesta del servidor:', result);
            
            if (result.success) {
                alert('Categorización creada correctamente');
                modalCrearCategorizacion.classList.remove('active');
                cargarCategorizacionesPredio(selectedPredioId);
                formCrearCategorizacion.reset();
            } else {
                alert('Error: ' + result.error);
            }
        } catch (error) {
            console.error('[ARBITRIOS] Error al crear categorización:', error);
            alert('Error al conectar con el servidor');
        }
    });
}
  
  // Formulario de clonar categorización
  if (formClonarCategorizacion) {
    formClonarCategorizacion.addEventListener('submit', async function(e) {
      e.preventDefault();
      
      const formData = new FormData(this);
      const data = {
        id_arbitrio_detalle: formData.get('id_arbitrio_detalle'),
        nuevo_anio: formData.get('nuevo_anio'),
        nuevo_item: formData.get('nuevo_item')
      };
      
      try {
        const response = await fetch('index.php?c=arbitrios&m=clonarCategorizacion', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(data)
        });
        
        const result = await response.json();
        
        if (result.success) {
          alert('Categorización clonada correctamente');
          modalClonarCategorizacion.classList.remove('active');
          cargarCategorizacionesPredio(selectedPredioId);
        } else {
          alert('Error: ' + result.error);
        }
      } catch (error) {
        console.error('[ARBITRIOS] Error al clonar categorización:', error);
        alert('Error al conectar con el servidor');
      }
    });
  }
  
  // ============ BOTONES DE CUENTA CORRIENTE ============
  const btnActualizarCtacte = document.getElementById('btnActualizarCtacte');
  const btnVerCtacte = document.getElementById('btnVerCtacte');
  
  if (btnActualizarCtacte) {
    btnActualizarCtacte.addEventListener('click', function() {
      const prediosSeleccionados = Array.from(document.querySelectorAll('.predio-checkbox:checked'))
        .map(cb => cb.dataset.predioId);
      
      if (prediosSeleccionados.length === 0) {
        alert('Por favor, seleccione al menos un predio');
        return;
      }
      
      if (confirm(`¿Actualizar cuenta corriente para ${prediosSeleccionados.length} predio(s)?`)) {
        // Aquí iría la lógica para actualizar cuenta corriente
        console.log('[ARBITRIOS] Actualizando cuenta corriente para predios:', prediosSeleccionados);
        alert('Función de actualización de cuenta corriente por implementar');
      }
    });
  }
  
  if (btnVerCtacte) {
    btnVerCtacte.addEventListener('click', function() {
      alert('Función de ver cuenta corriente por implementar');
    });
  }
  
  // ============ FUNCIONES PARA MODAL DE AGREGAR PREDIO ============
  function cerrarModal() {
    if (modalAgregarPredio) {
      modalAgregarPredio.classList.remove('active');
    }
    if (formAgregarPredio) {
      formAgregarPredio.reset();
    }
    if (predioList) {
      predioList.innerHTML = '';
      predioList.classList.remove('active');
    }
  }

  if (btnAgregarPredio && modalAgregarPredio) {
    console.log('[ARBITRIOS] Agregando listener a btnAgregarPredio');
    btnAgregarPredio.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      console.log('[ARBITRIOS] Click en Agregar Predio - abriendo modal...');
      modalAgregarPredio.classList.add('active');
      console.log('[ARBITRIOS] Modal abierto - clase active:', modalAgregarPredio.classList.contains('active'));
      if (predioSearch) {
        setTimeout(function() {
          predioSearch.focus();
        }, 100);
      }
    });
  } else {
    console.error('[ARBITRIOS] ERROR: No se encontraron btnAgregarPredio o modalAgregarPredio');
  }

  if (btnCerrarModal) {
    btnCerrarModal.addEventListener('click', function(e) {
      e.preventDefault();
      console.log('[ARBITRIOS] Cerrando modal (botón X)');
      cerrarModal();
    });
  }

  if (btnCancelarModal) {
    btnCancelarModal.addEventListener('click', function(e) {
      e.preventDefault();
      console.log('[ARBITRIOS] Cerrando modal (botón Cancelar)');
      cerrarModal();
    });
  }

  if (modalAgregarPredio) {
    modalAgregarPredio.addEventListener('click', function(event) {
      if (event.target === modalAgregarPredio) {
        console.log('[ARBITRIOS] Cerrando modal (click fuera)');
        cerrarModal();
      }
    });
  }

  // Búsqueda de predios en modal de agregar (MEJORADA - CONSULTA REAL)
  if (predioSearch) {
    let searchTimeout;
    
    predioSearch.addEventListener('input', function() {
      const searchTerm = this.value.trim();
      
      clearTimeout(searchTimeout);
      
      if (searchTerm.length < 2) {
        if (predioList) {
          predioList.innerHTML = '';
          predioList.classList.remove('active');
        }
        return;
      }
      
      searchTimeout = setTimeout(() => {
        buscarPrediosReales(searchTerm);
      }, 300);
    });

    document.addEventListener('click', function(event) {
      if (event.target !== predioSearch && event.target !== predioList && predioList) {
        predioList.classList.remove('active');
      }
    });
  }

  // Formulario de agregar predio (MEJORADO - AJAX REAL)
  if (formAgregarPredio) {
    console.log('[ARBITRIOS] Agregando listener al formulario');
    formAgregarPredio.addEventListener('submit', async function(event) {
      event.preventDefault();

      const predioId = document.getElementById('predioId').value;
      if (!predioId) {
        alert('Por favor, selecciona un predio de la lista.');
        return;
      }

      const formData = {
        id_contribuyente: document.querySelector('input[name="id_contribuyente"]').value,
        id_predio: predioId,
        estado: document.getElementById('estado').value,
        id_tipo_registro_origen: document.getElementById('referencia').value,
      };

      console.log('[ARBITRIOS] Enviando formulario:', formData);
      
      try {
        const response = await fetch('index.php?c=arbitrios&m=agregarPredio', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: new URLSearchParams(formData)
        });
        
        const result = await response.json();
        
        if (result.success) {
          alert('Predio agregado correctamente');
          cerrarModal();
          // Recargar la página para ver el nuevo predio
          window.location.reload();
        } else {
          alert('Error: ' + result.error);
        }
      } catch (error) {
        console.error('[ARBITRIOS] Error al agregar predio:', error);
        alert('Error al conectar con el servidor');
      }
    });
  } else {
    console.error('[ARBITRIOS] ERROR: No se encontró formAgregarPredio');
  }

  // ============ MODAL DE IMPORTACIÓN ============
  const modalImportar = createImportModal();
  document.body.appendChild(modalImportar);
  
  // Configurar botón de importar predios
  const btnImportarPredios = document.querySelector('.btn-secondary');
  if (btnImportarPredios) {
    btnImportarPredios.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      console.log('[ARBITRIOS] Abriendo modal de importación...');
      modalImportar.classList.add('active');
    });
  }

  // ============ SETUP DE TABLAS ============
  console.log('[ARBITRIOS] Llamando a setupTableActions()...');
  
  setTimeout(function() {
    setupTableActions();
  }, 50);
  
  console.log('[ARBITRIOS] === FIN INICIALIZACIÓN ARBITRIOS ===');
}

// ============ FUNCIONES AUXILIARES EXTERNAS ============

// ============ SETUP TABLE ACTIONS ============
function setupTableActions() {
  console.log('[ARBITRIOS] === SETUP TABLE ACTIONS ===');
  
  const tabla = document.querySelector('.arb-predios-table');
  console.log('[ARBITRIOS] Tabla encontrada:', tabla ? 'SÍ' : 'NO');
  
  if (!tabla) {
    console.warn('[ARBITRIOS] No hay tabla de predios en la página');
    return;
  }

  // Ver predio
  let botonesVer = document.querySelectorAll('table.arb-predios-table .btn-ver');
  console.log('[ARBITRIOS] Botones Ver encontrados:', botonesVer.length);
  
  botonesVer.forEach((btn, idx) => {
    console.log(`[ARBITRIOS] Agregando listener Ver #${idx}`, btn);
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      console.log('[ARBITRIOS] *** CLICK VER PREDIO #' + idx + ' ***');
      
      const fila = this.closest('tr');
      console.log('[ARBITRIOS] Fila encontrada:', fila ? 'SÍ' : 'NO');
      
      if (!fila) {
        console.error('[ARBITRIOS] ERROR: No se encontró fila (tr) desde botón Ver');
        alert('Error: No se encontró la fila del predio');
        return;
      }
      
      try {
        const codigo = fila.querySelector('td:nth-child(2)').textContent.trim();
        const estado = fila.querySelector('td:nth-child(1)').textContent.trim();
        const direccion = fila.querySelector('td:nth-child(3)').textContent.trim();
        console.log('[ARBITRIOS] Datos extraídos:', { codigo, estado, direccion });
        alert(`Ver Predio: ${codigo}\nEstado: ${estado}\nDirección: ${direccion}`);
      } catch(err) {
        console.error('[ARBITRIOS] Error al extraer datos:', err);
        alert('Error al extraer datos del predio');
      }
    });
  });

  // Editar predio
  let botonesEditar = document.querySelectorAll('table.arb-predios-table .btn-editar');
  console.log('[ARBITRIOS] Botones Editar encontrados:', botonesEditar.length);
  
  botonesEditar.forEach((btn, idx) => {
    console.log(`[ARBITRIOS] Agregando listener Editar #${idx}`, btn);
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      console.log('[ARBITRIOS] *** CLICK EDITAR PREDIO #' + idx + ' ***');
      
      const fila = this.closest('tr');
      console.log('[ARBITRIOS] Fila encontrada:', fila ? 'SÍ' : 'NO');
      
      if (!fila) {
        console.error('[ARBITRIOS] ERROR: No se encontró fila (tr) desde botón Editar');
        alert('Error: No se encontró la fila del predio');
        return;
      }
      
      try {
        const codigo = fila.querySelector('td:nth-child(2)').textContent.trim();
        console.log('[ARBITRIOS] Editando predio:', codigo);
        alert(`Editar Predio: ${codigo}\n(Modal de edición por implementar)`);
      } catch(err) {
        console.error('[ARBITRIOS] Error al extraer datos:', err);
        alert('Error al extraer datos del predio');
      }
    });
  });

  // Eliminar predio
  let botonesEliminar = document.querySelectorAll('table.arb-predios-table .btn-eliminar');
  console.log('[ARBITRIOS] Botones Eliminar encontrados:', botonesEliminar.length);

  botonesEliminar.forEach((btn, idx) => {
      btn.addEventListener('click', async function(e) {
          e.preventDefault();
          e.stopPropagation();
          
          const fila = this.closest('tr');
          const predioId = this.dataset.predioId;
          const contribuyenteId = this.dataset.contribuyenteId; // ← OBTENER DESDE DATA ATRIBUTE
          
          console.log('[ARBITRIOS] Datos:', { predioId, contribuyenteId });
          
          if (!fila || !predioId || !contribuyenteId) {
              alert('Error: No se pudo obtener información del predio o contribuyente');
              return;
          }
          
          const codigo = fila.querySelector('td:nth-child(3)').textContent.trim();
          
          if (!confirm(`¿Está seguro de eliminar el predio "${codigo}" de arbitrios?\n\nEsta acción eliminará todas las categorizaciones asociadas.`)) {
              return;
          }
          
          // Mostrar carga
          const originalHTML = this.innerHTML;
          this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
          this.disabled = true;
          
          try {
              console.log(`[ARBITRIOS] Eliminando predio ID: ${predioId}, Contribuyente: ${contribuyenteId}`);
              
              const response = await fetch(
                  `index.php?c=arbitrios&m=eliminarPredio&id_predio=${predioId}&id_contribuyente=${contribuyenteId}`,
                  {
                      method: 'GET',
                      headers: {
                          'Accept': 'application/json'
                      }
                  }
              );
              
              if (!response.ok) {
                  throw new Error(`Error HTTP: ${response.status}`);
              }
              
              const result = await response.json();
              console.log('[ARBITRIOS] Resultado:', result);
              
              if (result.success) {
                  // Eliminar del DOM
                  fila.remove();
                  console.log('[ARBITRIOS] Predio eliminado correctamente');
                  
                  // Mostrar mensaje
                  alert(result.message);
                  
                  // Actualizar contador si es necesario
                  const totalFilas = document.querySelectorAll('#prediosTableBody tr').length;
                  if (totalFilas === 0) {
                      document.querySelector('#prediosTableBody').innerHTML = 
                          '<tr><td colspan="11" class="text-center">No hay predios registrados para este contribuyente.</td></tr>';
                  }
                  
                  // Si estaba seleccionado, ocultar categorización
                  if (selectedPredioId === predioId) {
                      ocultarCategorizacion();
                  }
                  
              } else {
                  alert('Error: ' + result.error);
                  this.innerHTML = originalHTML;
                  this.disabled = false;
              }
              
          } catch (error) {
              console.error('[ARBITRIOS] Error completo:', error);
              alert('Error: ' + error.message);
              this.innerHTML = originalHTML;
              this.disabled = false;
          }
      });
  });
  
  console.log('[ARBITRIOS] === FIN SETUP TABLE ACTIONS ===');
}

// ============ FUNCIÓN PARA BUSCAR PREDIOS REALES ============
async function buscarPrediosReales(searchTerm) {
  const predioList = document.getElementById('predioList');
  
  if (!predioList) return;
  
  // Mostrar carga
  predioList.innerHTML = '<div class="arb-dropdown-item loading"><i class="fas fa-spinner fa-spin"></i> Buscando predios...</div>';
  predioList.classList.add('active');
  
  try {
    const response = await fetch(`index.php?c=arbitrios&m=buscarPredios&q=${encodeURIComponent(searchTerm)}`);
    const result = await response.json();
    
    predioList.innerHTML = '';
    
    if (result.success && result.data.length > 0) {
      result.data.forEach(predio => {
        const item = document.createElement('div');
        item.className = 'arb-dropdown-item';
        item.innerHTML = `<strong>${predio.codigo_catastral || predio.id}</strong> - ${predio.direccion}`;
        item.addEventListener('click', function() {
          document.getElementById('predioId').value = predio.id;
          document.getElementById('predioSearch').value = `${predio.codigo_catastral || predio.id} - ${predio.direccion}`;
          if (predioList) {
            predioList.classList.remove('active');
          }
        });
        predioList.appendChild(item);
      });
    } else {
      predioList.innerHTML = '<div class="arb-dropdown-item">No se encontraron predios</div>';
    }
  } catch (error) {
    console.error('[ARBITRIOS] Error en búsqueda de predios:', error);
    predioList.innerHTML = '<div class="arb-dropdown-item error">Error en la búsqueda</div>';
  }
}

// ============ FUNCIÓN PARA CREAR MODAL DE IMPORTACIÓN ============
function createImportModal() {
  const modal = document.createElement('div');
  modal.id = 'modalImportarPredios';
  modal.className = 'arb-modal';
  modal.innerHTML = `
    <div class="arb-modal-content arb-modal-import">
      <div class="arb-modal-header">
        <h2><i class="fas fa-file-import"></i> Importar Predios Desde</h2>
        <button class="arb-modal-close" id="btnCerrarImport">&times;</button>
      </div>
      
      <div class="arb-modal-body">
        <!-- Paso 1: Seleccionar fuente -->
        <div id="step1" class="import-step active">
          <h3><i class="fas fa-database"></i> Seleccionar Fuente de Datos</h3>
          <p>Elija de dónde desea importar los predios:</p>
          
          <div class="import-options">
            <div class="import-option" data-source="licencias">
              <div class="import-option-icon">
                <i class="fas fa-id-card fa-3x"></i>
              </div>
              <div class="import-option-content">
                <h4>Licencias de Funcionamiento</h4>
                <p>Importar predios registrados en licencias comerciales activas</p>
              </div>
              <div class="import-option-arrow">
                <i class="fas fa-chevron-right"></i>
              </div>
            </div>
            
            <div class="import-option" data-source="declaraciones">
              <div class="import-option-icon">
                <i class="fas fa-file-signature fa-3x"></i>
              </div>
              <div class="import-option-content">
                <h4>Declaraciones Juradas</h4>
                <p>Importar predios de declaraciones juradas registradas</p>
              </div>
              <div class="import-option-arrow">
                <i class="fas fa-chevron-right"></i>
              </div>
            </div>
          </div>
        </div>
        
        <!-- Paso 2: Seleccionar predios -->
        <div id="step2" class="import-step">
          <div class="import-step-header">
            <button class="btn-back" id="btnBackToSource">
              <i class="fas fa-arrow-left"></i> Volver
            </button>
            <h3 id="step2Title"></h3>
          </div>
          
          <div class="import-search">
            <input type="text" id="searchPredios" placeholder="Buscar predios..." class="arb-search-input">
          </div>
          
          <div class="import-table-wrapper">
            <table class="import-table">
              <thead>
                <tr>
                  <th width="50">
                    <input type="checkbox" id="selectAllPredios">
                  </th>
                  <th>Código</th>
                  <th>Dirección del Predio</th>
                  <th>Información Adicional</th>
                </tr>
              </thead>
              <tbody id="prediosList">
                <!-- Predios se cargarán aquí -->
              </tbody>
            </table>
          </div>
          
          <div class="import-selection-info">
            <span id="selectedCount">0 predios seleccionados</span>
          </div>
          
          <div class="import-step-actions">
            <button class="btn-cancelar" id="btnCancelImport">Salir</button>
            <button class="btn-grabar" id="btnImportSelected" disabled>Aceptar (0)</button>
          </div>
        </div>
      </div>
    </div>
  `;
  
  // Configurar eventos del modal de importación
  setTimeout(() => {
    setupImportModalEvents(modal);
  }, 100);
  
  return modal;
}

// ============ CONFIGURAR EVENTOS DEL MODAL DE IMPORTACIÓN ============
function setupImportModalEvents(modal) {
  const modalImportar = modal;
  const btnCerrarImport = modal.querySelector('#btnCerrarImport');
  const btnCancelImport = modal.querySelector('#btnCancelImport');
  const importOptions = modal.querySelectorAll('.import-option');
  const btnBackToSource = modal.querySelector('#btnBackToSource');
  const selectAllPredios = modal.querySelector('#selectAllPredios');
  const btnImportSelected = modal.querySelector('#btnImportSelected');
  const searchPredios = modal.querySelector('#searchPredios');
  
  // Obtener ID del contribuyente
  const urlParams = new URLSearchParams(window.location.search);
  const idContribuyente = urlParams.get('id');
  
  // Cerrar modal
  if (btnCerrarImport) {
    btnCerrarImport.addEventListener('click', closeImportModal);
  }
  
  if (btnCancelImport) {
    btnCancelImport.addEventListener('click', closeImportModal);
  }
  
  modalImportar.addEventListener('click', function(event) {
    if (event.target === modalImportar) {
      closeImportModal();
    }
  });
  
  // Seleccionar fuente de datos
  importOptions.forEach(option => {
    option.addEventListener('click', function() {
      const source = this.dataset.source;
      const step2Title = modal.querySelector('#step2Title');
      
      if (source === 'licencias') {
        step2Title.innerHTML = '<i class="fas fa-id-card"></i> Licencias de Funcionamiento';
        loadLicencias(idContribuyente);
      } else if (source === 'declaraciones') {
        step2Title.innerHTML = '<i class="fas fa-file-signature"></i> Declaraciones Juradas';
        loadDeclaraciones(idContribuyente);
      }
      
      // Cambiar al paso 2
      modal.querySelector('#step1').classList.remove('active');
      modal.querySelector('#step2').classList.add('active');
    });
  });
  
  // Volver al paso 1
  if (btnBackToSource) {
    btnBackToSource.addEventListener('click', function() {
      modal.querySelector('#step2').classList.remove('active');
      modal.querySelector('#step1').classList.add('active');
      clearPrediosList();
    });
  }
  
  // Seleccionar todos los predios
  if (selectAllPredios) {
    selectAllPredios.addEventListener('change', function() {
      const checkboxes = modal.querySelectorAll('.predio-checkbox');
      checkboxes.forEach(cb => {
        cb.checked = this.checked;
      });
      updateSelectedCount();
    });
  }
  
  // Importar predios seleccionados
  if (btnImportSelected) {
    btnImportSelected.addEventListener('click', function() {
      importSelectedPredios(idContribuyente);
    });
  }
  
  // Buscar predios
  if (searchPredios) {
    searchPredios.addEventListener('input', function() {
      filterPredios(this.value.toLowerCase());
    });
  }
  
  function closeImportModal() {
    modalImportar.classList.remove('active');
    // Resetear al paso 1
    modal.querySelector('#step2').classList.remove('active');
    modal.querySelector('#step1').classList.add('active');
    clearPrediosList();
  }
}

// ============ CARGAR LICENCIAS DE FUNCIONAMIENTO (REAL) ============
async function loadLicencias(idContribuyente) {
  const prediosList = document.querySelector('#prediosList');
  const loadingHTML = `
    <tr>
      <td colspan="4" class="text-center loading">
        <i class="fas fa-spinner fa-spin"></i> Cargando licencias de funcionamiento...
      </td>
    </tr>
  `;
  prediosList.innerHTML = loadingHTML;
  
  try {
    const response = await fetch(`index.php?c=arbitrios&m=getLicencias&id=${idContribuyente}`);
    const result = await response.json();
    
    if (result.success) {
      displayPredios(result.data, 'licencias');
    } else {
      prediosList.innerHTML = `
        <tr>
          <td colspan="4" class="text-center error">
            <i class="fas fa-exclamation-triangle"></i> ${result.error || 'Error al cargar licencias'}
          </td>
        </tr>
      `;
    }
  } catch (error) {
    console.error('[ARBITRIOS] Error al cargar licencias:', error);
    prediosList.innerHTML = `
      <tr>
        <td colspan="4" class="text-center error">
          <i class="fas fa-exclamation-triangle"></i> Error de conexión
        </td>
      </tr>
    `;
  }
}

// ============ CARGAR DECLARACIONES JURADAS (REAL) ============
async function loadDeclaraciones(idContribuyente) {
  const prediosList = document.querySelector('#prediosList');
  const loadingHTML = `
    <tr>
      <td colspan="4" class="text-center loading">
        <i class="fas fa-spinner fa-spin"></i> Cargando declaraciones juradas...
      </td>
    </tr>
  `;
  prediosList.innerHTML = loadingHTML;
  
  try {
    const response = await fetch(`index.php?c=arbitrios&m=getDeclaraciones&id=${idContribuyente}`);
    const result = await response.json();
    
    if (result.success) {
      displayPredios(result.data, 'declaraciones');
    } else {
      prediosList.innerHTML = `
        <tr>
          <td colspan="4" class="text-center error">
            <i class="fas fa-exclamation-triangle"></i> ${result.error || 'Error al cargar declaraciones'}
          </td>
        </tr>
      `;
    }
  } catch (error) {
    console.error('[ARBITRIOS] Error al cargar declaraciones:', error);
    prediosList.innerHTML = `
      <tr>
        <td colspan="4" class="text-center error">
          <i class="fas fa-exclamation-triangle"></i> Error de conexión
        </td>
      </tr>
    `;
  }
}

// ============ MOSTRAR PREDIOS EN TABLA ============
function displayPredios(predios, sourceType) {
  const prediosList = document.querySelector('#prediosList');
  let html = '';
  
  if (predios.length === 0) {
    html = `
      <tr>
        <td colspan="4" class="text-center empty">
          <i class="fas fa-inbox"></i> No se encontraron predios para importar
        </td>
      </tr>
    `;
  } else {
    predios.forEach((predio, index) => {
      html += `
        <tr class="predio-row">
          <td>
            <input type="checkbox" 
                   class="predio-checkbox" 
                   data-id="${predio.id}"
                   data-id_predio="${predio.id_predio}"
                   data-codigo="${predio.codigo}"
                   data-direccion="${predio.direccion}"
                   data-adicional="${predio.adicional}"
                   data-source="${sourceType}">
          </td>
          <td class="predio-codigo">${predio.codigo}</td>
          <td class="predio-direccion">${predio.direccion}</td>
          <td class="predio-adicional">${predio.adicional}</td>
        </tr>
      `;
    });
  }
  
  prediosList.innerHTML = html;
  
  // Agregar eventos a los checkboxes
  const checkboxes = prediosList.querySelectorAll('.predio-checkbox');
  checkboxes.forEach(cb => {
    cb.addEventListener('change', updateSelectedCount);
  });
  
  // Resetear "Seleccionar todos"
  const selectAll = document.querySelector('#selectAllPredios');
  if (selectAll) selectAll.checked = false;
  
  updateSelectedCount();
}

// ============ ACTUALIZAR CONTADOR DE SELECCIONADOS ============
function updateSelectedCount() {
  const checkboxes = document.querySelectorAll('.predio-checkbox:checked');
  const count = checkboxes.length;
  const selectedCount = document.querySelector('#selectedCount');
  const btnImportSelected = document.querySelector('#btnImportSelected');
  
  if (selectedCount) {
    selectedCount.textContent = `${count} predio${count !== 1 ? 's' : ''} seleccionado${count !== 1 ? 's' : ''}`;
  }
  
  if (btnImportSelected) {
    btnImportSelected.disabled = count === 0;
    btnImportSelected.textContent = `Aceptar (${count})`;
  }
  
  // Actualizar "Seleccionar todos"
  const allCheckboxes = document.querySelectorAll('.predio-checkbox');
  const selectAll = document.querySelector('#selectAllPredios');
  if (selectAll && allCheckboxes.length > 0) {
    selectAll.checked = count === allCheckboxes.length;
    selectAll.indeterminate = count > 0 && count < allCheckboxes.length;
  }
}

// ============ FILTRAR PREDIOS EN BÚSQUEDA ============
function filterPredios(searchTerm) {
  const rows = document.querySelectorAll('.predio-row');
  let visibleCount = 0;
  
  rows.forEach(row => {
    const codigo = row.querySelector('.predio-codigo').textContent.toLowerCase();
    const direccion = row.querySelector('.predio-direccion').textContent.toLowerCase();
    const adicional = row.querySelector('.predio-adicional').textContent.toLowerCase();
    
    const match = codigo.includes(searchTerm) || 
                  direccion.includes(searchTerm) || 
                  adicional.includes(searchTerm);
    
    row.style.display = match ? '' : 'none';
    if (match) visibleCount++;
  });
  
  // Mostrar mensaje si no hay resultados
  const tableBody = document.querySelector('#prediosList');
  const noResultsRow = tableBody.querySelector('.no-results');
  
  if (visibleCount === 0 && searchTerm) {
    if (!noResultsRow) {
      const row = document.createElement('tr');
      row.className = 'no-results';
      row.innerHTML = `
        <td colspan="4" class="text-center">
          <i class="fas fa-search"></i> No se encontraron predios para "${searchTerm}"
        </td>
      `;
      tableBody.appendChild(row);
    }
  } else if (noResultsRow) {
    noResultsRow.remove();
  }
}

// ============ IMPORTAR PREDIOS SELECCIONADOS (REAL) ============
async function importSelectedPredios(idContribuyente) {
  const checkboxes = document.querySelectorAll('.predio-checkbox:checked');
  const selectedPredios = [];
  
  checkboxes.forEach(cb => {
    selectedPredios.push({
      id: cb.dataset.id,
      id_predio: cb.dataset.id_predio,
      codigo: cb.dataset.codigo,
      direccion: cb.dataset.direccion,
      adicional: cb.dataset.adicional
    });
  });
  
  if (selectedPredios.length === 0) {
    alert('Por favor, seleccione al menos un predio para importar.');
    return;
  }
  
  console.log('[ARBITRIOS] Importando predios:', selectedPredios);
  
  // Determinar tipo de fuente (licencias o declaraciones)
  const sourceType = checkboxes[0]?.dataset.source || 'licencias';
  const sourceName = sourceType === 'licencias' ? 'Licencias de Funcionamiento' : 'Declaraciones Juradas';
  
  // Mostrar confirmación con detalles
  const confirmMessage = `¿Está seguro de importar ${selectedPredios.length} predio(s) desde ${sourceName} a arbitrios?\n\n` +
                        'Nota: Solo se importarán los predios que no estén ya registrados.';
  
  if (!confirm(confirmMessage)) {
    return;
  }
  
  // Realizar importación
  await executeImport(idContribuyente, selectedPredios, sourceType);
}

// ============ EJECUTAR IMPORTACIÓN REAL ============
async function executeImport(idContribuyente, predios, sourceType) {
  const modal = document.querySelector('#modalImportarPredios');
  const step2 = modal.querySelector('#step2');
  
  const progressHTML = `
    <div class="import-progress">
      <h3><i class="fas fa-sync fa-spin"></i> Importando predios...</h3>
      <div class="progress-bar">
        <div class="progress-fill" id="progressFill" style="width: 0%"></div>
      </div>
      <p id="progressText">Procesando 0 de ${predios.length}</p>
    </div>
  `;
  
  step2.innerHTML = progressHTML;
  
  try {
    // Enviar datos al servidor
    const response = await fetch('index.php?c=arbitrios&m=importarPredios', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        id_contribuyente: idContribuyente,
        predios: predios,
        tipo_fuente: sourceType
      })
    });
    
    const result = await response.json();
    
    // Mostrar resultado detallado
    if (result.success) {
      let detallesHTML = '';
      if (result.detalles && result.detalles.length > 0) {
        detallesHTML = result.detalles.map(d => `<li>${d}</li>`).join('');
      }
      
      step2.innerHTML = `
        <div class="import-success">
          <i class="fas fa-check-circle fa-4x" style="color: #28a745;"></i>
          <h3>¡Proceso completado!</h3>
          <div class="import-summary">
            <div class="summary-item success">
              <i class="fas fa-check-circle"></i>
              <span>Importados: <strong>${result.importados}</strong></span>
            </div>
            <div class="summary-item warning">
              <i class="fas fa-info-circle"></i>
              <span>Ya existían: <strong>${result.no_importados}</strong></span>
            </div>
            <div class="summary-item total">
              <i class="fas fa-list"></i>
              <span>Total procesados: <strong>${result.total_procesados}</strong></span>
            </div>
          </div>
          ${result.detalles && result.detalles.length > 0 ? 
            `<div class="import-details">
              <h4>Detalles:</h4>
              <ul class="details-list">${detallesHTML}</ul>
            </div>` : ''}
          <div class="success-actions">
            <button class="btn-grabar" id="btnCloseImport">Cerrar y actualizar página</button>
          </div>
        </div>
      `;
    } else {
      step2.innerHTML = `
        <div class="import-error">
          <i class="fas fa-times-circle fa-4x" style="color: #dc3545;"></i>
          <h3>Error en la importación</h3>
          <p>${result.error || 'Error desconocido'}</p>
          <div class="error-actions">
            <button class="btn-cancelar" id="btnCloseImport">Volver</button>
          </div>
        </div>
      `;
    }
    
    // Agregar evento para cerrar
    const btnCloseImport = step2.querySelector('#btnCloseImport');
    if (btnCloseImport) {
      btnCloseImport.addEventListener('click', () => {
        modal.classList.remove('active');
        // Resetear al paso 1
        modal.querySelector('#step2').classList.remove('active');
        modal.querySelector('#step1').classList.add('active');
        clearPrediosList();
        
        // Recargar la página para ver los cambios
        if (result.success) {
          setTimeout(() => {
            window.location.reload();
          }, 500);
        }
      });
    }
    
  } catch (error) {
    console.error('[ARBITRIOS] Error en importación:', error);
    step2.innerHTML = `
      <div class="import-error">
        <i class="fas fa-times-circle fa-4x" style="color: #dc3545;"></i>
        <h3>Error de conexión</h3>
        <p>No se pudo conectar con el servidor</p>
        <div class="error-actions">
          <button class="btn-cancelar" id="btnCloseImport">Volver</button>
        </div>
      </div>
    `;
  }
}

// ============ LIMPIAR LISTA DE PREDIOS ============
function clearPrediosList() {
  const prediosList = document.querySelector('#prediosList');
  if (prediosList) prediosList.innerHTML = '';
  
  // Resetear contadores
  updateSelectedCount();
  
  // Limpiar búsqueda
  const searchInput = document.querySelector('#searchPredios');
  if (searchInput) searchInput.value = '';
}