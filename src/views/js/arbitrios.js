
console.log('[ARBITRIOS] Script cargado. readyState:', document.readyState);

let selectedPredioId = null;
let selectedPredioData = null;

function validarCampoEnTiempoReal(campo) {
    const valor = campo.value;
    const nombre = campo.name;
    const tipo = campo.type;
    
    
    campo.style.borderColor = '';
    campo.style.backgroundColor = '';
    
    if (!valor || valor === '' || valor === '0') {
        campo.style.borderColor = '#ecf0f1';
        return true;
    }
    
    
    if (tipo === 'number') {
        const num = parseFloat(valor);
        if (isNaN(num)) {
            campo.style.borderColor = '#e74c3c';
            return false;
        }
        if (num < 0) {
            campo.style.borderColor = '#e74c3c';
            return false;
        }
        
        campo.style.borderColor = '#27ae60';
        campo.style.backgroundColor = '#f0fff4';
    }
    
    return true;
}

function validarMesesSeleccionados() {
    const mesCheckboxes = document.querySelectorAll('.mes-checkbox:checked');
    const mesCheckboxContainer = document.querySelector('.meses-grid-2col');
    if (mesCheckboxes.length > 0 && mesCheckboxContainer) {
        mesCheckboxContainer.style.borderLeft = '4px solid #27ae60';
        mesCheckboxContainer.parentElement.style.backgroundColor = '#f0fff4';
    }
}

if (document.readyState === 'loading') {
  console.log('[ARBITRIOS] DOM aún cargando, esperando DOMContentLoaded...');
  document.addEventListener('DOMContentLoaded', initializeArbitrios);
} else {
  console.log('[ARBITRIOS] DOM ya listo, inicializando directamente...');
  setTimeout(initializeArbitrios, 100);
}

function initializeArbitrios() {
  console.log('[ARBITRIOS] === INICIANDO ARBITRIOS ===');
  
  
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
  
  
  const btnCrearCategorizacion = document.getElementById('btnCrearCategorizacion');
  const btnClonarCategorizacion = document.getElementById('btnClonarCategorizacion');
  const modalCrearCategorizacion = document.getElementById('modalCrearCategorizacion');
  const modalClonarCategorizacion = document.getElementById('modalClonarCategorizacion');
  const formCrearCategorizacion = document.getElementById('formCrearCategorizacion');
  const formClonarCategorizacion = document.getElementById('formClonarCategorizacion');
  
  
  const selectAllPredios = document.getElementById('selectAllPredios');
  if (selectAllPredios) {
    selectAllPredios.addEventListener('change', function() {
      const checkboxes = document.querySelectorAll('.predio-checkbox');
      checkboxes.forEach(cb => {
        cb.checked = this.checked;
      });
      actualizarBadgeSeleccionPredios();
    });
  }
  
  
  document.addEventListener('change', function(e) {
    if (e.target.classList.contains('predio-checkbox')) {
      const predioId = e.target.dataset.predioId;
      const predioRow = e.target.closest('.predio-row');

      
      
      if (e.target.checked) {
        mostrarCategorizacionPredio(predioId, predioRow);
      } else {
        
        if (window.selectedPredioId === predioId) {
          const otroMarcado = document.querySelector('.predio-checkbox:checked');
          if (otroMarcado) {
            const row = otroMarcado.closest('.predio-row');
            mostrarCategorizacionPredio(otroMarcado.dataset.predioId, row);
          } else {
            ocultarCategorizacion();
          }
        }
      }
      actualizarBadgeSeleccionPredios();
    }
  });

  
  function mostrarCategorizacionPredio(predioId, predioRow) {
    selectedPredioId = predioId;
    window.selectedPredioId = selectedPredioId;
    
    
    const cells = predioRow.querySelectorAll('td');
    selectedPredioData = {
      estado: cells[1].textContent.trim(),
      codigo: cells[2].textContent.trim(),
      direccion: cells[3].textContent.trim(),
      referencia: cells[4].textContent.trim()
    };
    
    
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
      
      
      cargarCategorizacionesPredio(predioId);
    }
  }
  
  
  window.ocultarCategorizacion = function ocultarCategorizacion() {
    selectedPredioId = null;
    selectedPredioData = null;
    window.selectedPredioId = null;
    
    const categorizacionSection = document.getElementById('categorizacionSection');
    if (categorizacionSection) {
      categorizacionSection.style.display = 'none';
    }
  }
  

async function cargarCategorizacionesPredio(predioId) {
    
    let tableBody = document.getElementById('categorizacionesTableBody');
    
    
    if (!tableBody) {
        const categoriasContent = document.getElementById('categoriasContent');
        if (categoriasContent) {
            tableBody = categoriasContent.querySelector('#categorizacionesTableBody');
        }
    }
    
    if (!tableBody) {
        console.error('[ARBITRIOS] ERROR: No se encontró categorizacionesTableBody en ningún lugar');
        return;
    }
    
    
    let contribuyenteId = idContribuyente;
    if (!contribuyenteId) {
        const elem = document.getElementById('idContribuyente');
        if (elem) contribuyenteId = elem.value;
    }
    
    if (!contribuyenteId) {
        tableBody.innerHTML = `
          <tr>
            <td colspan="30" class="text-center error">
              <i class="fas fa-exclamation-triangle"></i> Error: No se encontró el ID de contribuyente
            </td>
          </tr>
        `;
        return;
    }
    
    
    tableBody.innerHTML = `
      <tr>
        <td colspan="30" class="text-center loading">
          <i class="fas fa-spinner fa-spin"></i> Cargando categorizaciones...
        </td>
      </tr>
    `;
    
    try {
      
      
      const timestamp = new Date().getTime();
      console.log('[ARBITRIOS] Petición con predio:', predioId, 'contribuyente:', contribuyenteId);
      const response = await fetch(
        `index.php?c=arbitrios&m=getCategorizacionesPredio&id_predio=${predioId}&id_contribuyente=${contribuyenteId}&_t=${timestamp}`
      );
      const result = await response.json();
      
      console.log('[ARBITRIOS] Respuesta del servidor:', result);
      
      if (result.success) {
        
        
        const datos = result.datos || result.data || [];
        console.log('[ARBITRIOS] Datos a mostrar:', datos);
        mostrarCategorizaciones(datos);
      } else {
        
        tableBody.innerHTML = `
          <tr>
            <td colspan="30" class="text-center error">
              <i class="fas fa-exclamation-triangle"></i> Error del servidor: ${result.error}
            </td>
          </tr>
        `;
      }
    } catch (error) {
      
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
  
  let tableBody = document.getElementById('categorizacionesTableBody');
  if (!tableBody) {
    const categoriasContent = document.getElementById('categoriasContent');
    if (categoriasContent) {
      tableBody = categoriasContent.querySelector('#categorizacionesTableBody');
    }
  }
  if (!tableBody) return;
    
  
  const currentRows = tableBody.querySelectorAll('tr');
  const hasExistingDataRows = Array.from(currentRows).some(tr => !tr.classList.contains('loading') && !tr.classList.contains('error'));
    
  if (categorizaciones.length === 0) {
    if (!hasExistingDataRows) {
      tableBody.innerHTML = `
        <tr>
          <td colspan="30" class="text-center">
            <i class="fas fa-inbox"></i> No hay categorizaciones registradas
          </td>
        </tr>
      `;
    }
    return;
  }
    
    let html = '';
    
    categorizaciones.forEach((cat, index) => {
        
        const getMesClass = (mes) => mes == 1 ? 'mes-activo' : 'mes-inactivo';
        const getMesText = (mes) => mes == 1 ? '✓' : '✗';
        
        html += `
            <tr>
                <td class="categorizacion-actions">
                    <div class="action-buttons-grid">
                        <button class="btn-ver-cat btn-ver btn-icon" title="Ver detalle de la categorización" data-id="${cat.id_arbitrio_detalle}">
                            <i class="fas fa-eye"></i>
                        </button>
                        <button class="btn-editar-cat btn-editar btn-icon" title="Editar categorización" data-id="${cat.id_arbitrio_detalle}">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn-clonar-cat btn-clonar btn-icon" title="Clonar a otro año" data-id="${cat.id_arbitrio_detalle}">
                            <i class="fas fa-clone"></i>
                        </button>
                        <button class="btn-eliminar-cat btn-eliminar btn-icon" title="Eliminar categorización" data-id="${cat.id_arbitrio_detalle}">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
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
    
    
    agregarEventosCategorizaciones();
}
  
  function agregarEventosCategorizaciones() {
    const tableBody = document.getElementById('categorizacionesTableBody') || document.querySelector('#categoriasContent #categorizacionesTableBody');
    if (!tableBody) return;
    if (tableBody.__delegated) return; 
    tableBody.__delegated = true;

    tableBody.addEventListener('click', async function(e) {
      const btn = e.target.closest('button');
      if (!btn) return;

      
      if (btn.classList.contains('btn-ver-cat')) {
        e.preventDefault();
        const idDetalle = btn.dataset.id;
        try {
          const fila = btn.closest('tr');
          if (!fila) return;
          const celdas = fila.querySelectorAll('td');
          const dato = {
            id_arbitrio_detalle: idDetalle,
            anio: celdas[1].textContent.trim(),
            item: celdas[2].textContent.trim(),
            categoria_limpieza: celdas[15].textContent.trim(),
            categoria_parques: celdas[16].textContent.trim(),
            categoria_residuos: celdas[17].textContent.trim(),
            categoria_serenazgo: celdas[18].textContent.trim(),
            exoneracion_limpieza: celdas[19].textContent.trim(),
            exoneracion_parques: celdas[20].textContent.trim(),
            exoneracion_residuos: celdas[21].textContent.trim(),
            exoneracion_serenazgo: celdas[22].textContent.trim(),
            monto_base: celdas[23].textContent.trim(),
            interes: celdas[24].textContent.trim(),
            mora: celdas[25].textContent.trim(),
            monto_final: celdas[26].textContent.trim(),
            usuario_actualizado: celdas[27].textContent.trim(),
            fecha_actualizado: celdas[28].textContent.trim()
          };
          const tempDiv = document.createElement('div');
          tempDiv.innerHTML = `
            <div class="arb-modal" id="modalVerCategorizacion" style="display: flex;">
              <div class="arb-modal-content arb-modal-medium">
                <div class="arb-modal-header">
                  <h2><i class="fas fa-file-contract"></i> Detalle de Categorización</h2>
                  <button class="arb-modal-close" id="btnCerrarVerCat">&times;</button>
                </div>
                <div class="arb-modal-body">
                  <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                    <div><strong>Año:</strong><br/><span>${dato.anio}</span></div>
                    <div><strong>Item:</strong><br/><span>${dato.item}</span></div>
                    <div><strong>Categoría Limpieza:</strong><br/><span>${dato.categoria_limpieza}</span></div>
                    <div><strong>Categoría Parques:</strong><br/><span>${dato.categoria_parques}</span></div>
                    <div><strong>Categoría Residuos:</strong><br/><span>${dato.categoria_residuos}</span></div>
                    <div><strong>Categoría Serenazgo:</strong><br/><span>${dato.categoria_serenazgo}</span></div>
                    <div><strong>Exoneración Limpieza:</strong><br/><span>${dato.exoneracion_limpieza}</span></div>
                    <div><strong>Exoneración Parques:</strong><br/><span>${dato.exoneracion_parques}</span></div>
                    <div><strong>Exoneración Residuos:</strong><br/><span>${dato.exoneracion_residuos}</span></div>
                    <div><strong>Exoneración Serenazgo:</strong><br/><span>${dato.exoneracion_serenazgo}</span></div>
                    <div><strong>Monto Base:</strong><br/><span style="color: #28a745; font-weight: bold;">${dato.monto_base}</span></div>
                    <div><strong>Interés:</strong><br/><span>${dato.interes}</span></div>
                    <div><strong>Mora:</strong><br/><span>${dato.mora}</span></div>
                    <div><strong>Monto Final:</strong><br/><span style="color: #2196F3; font-weight: bold; font-size: 16px;">${dato.monto_final}</span></div>
                    <div><strong>Registrado por:</strong><br/><span>${dato.usuario_actualizado}</span></div>
                    <div><strong>Fecha:</strong><br/><span>${dato.fecha_actualizado}</span></div>
                  </div>
                  <div class="arb-form-buttons" style="margin-top: 20px;">
                    <button type="button" class="btn-secondary" id="btnCerrarVerCatBtn">Cerrar</button>
                  </div>
                </div>
              </div>
            </div>`;
          document.body.appendChild(tempDiv.firstChild);
          const modal = document.getElementById('modalVerCategorizacion');
          const btnCerrar = document.getElementById('btnCerrarVerCat');
          const btnCerrarBtn = document.getElementById('btnCerrarVerCatBtn');
          const cerrarModal = () => modal.remove();
          if (btnCerrar) btnCerrar.addEventListener('click', cerrarModal);
          if (btnCerrarBtn) btnCerrarBtn.addEventListener('click', cerrarModal);
          if (modal) modal.addEventListener('click', (ev) => { if (ev.target === modal) cerrarModal(); });
        } catch (error) {
          console.error('[ARBITRIOS] Error:', error);
          alert('❌ Error al cargar los detalles');
        }
        return;
      }

      
      if (btn.classList.contains('btn-eliminar-cat')) {
        e.preventDefault();
        const idDetalle = btn.dataset.id;
        if (!confirm('⚠️ ¿Está seguro de eliminar esta categorización? Esta acción no se puede deshacer')) return;
        const originalHTML = btn.innerHTML;
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
        btn.disabled = true;
        try {
          const response = await fetch(`index.php?c=arbitrios&m=eliminarCategorizacion&id_detalle=${idDetalle}`, { method: 'GET' });
          const result = await response.json();
          if (result.success) {
            alert('✅ Categorización eliminada correctamente');
            btn.innerHTML = originalHTML;
            btn.disabled = false;
            cargarCategorizacionesPredio(selectedPredioId);
          } else {
            alert('❌ Error: ' + result.error);
            btn.innerHTML = originalHTML;
            btn.disabled = false;
          }
        } catch (err) {
          console.error('[ARBITRIOS] Error al eliminar:', err);
          alert('❌ Error al conectar con el servidor');
          btn.innerHTML = originalHTML;
          btn.disabled = false;
        }
        return;
      }

      
      if (btn.classList.contains('btn-editar-cat')) {
        e.preventDefault();
        const idDetalle = btn.dataset.id;
        try {
          await abrirModalEditarCategorizacion(idDetalle);
        } catch (err) {
          console.error('[ARBITRIOS] Error abriendo editor:', err);
          alert('❌ No se pudo cargar el detalle para editar');
        }
        return;
      }

      
      if (btn.classList.contains('btn-clonar-cat')) {
        e.preventDefault();
        const idDetalle = btn.dataset.id;
        const fila = btn.closest('tr');
        const anioActual = parseInt(fila.querySelector('td:nth-child(2)').textContent.trim());
        document.getElementById('clonarIdDetalle').value = idDetalle;
        document.getElementById('clonarAnio').value = anioActual + 1;
        modalClonarCategorizacion.classList.add('active');
        return;
      }
    });
  }
  
  
  if (btnCrearCategorizacion && modalCrearCategorizacion) {
    btnCrearCategorizacion.addEventListener('click', function() {
      if (!selectedPredioId) {
        alert('Por favor, seleccione un predio primero');
        return;
      }
      
      
      const contribuyenteHeader = document.querySelector('.arb-contribuyente-header .contribuyente-name');
      const nombreContribuyente = contribuyenteHeader ? contribuyenteHeader.textContent : '';
      
      
      if (selectedPredioData) {
        document.getElementById('catContribuyente').textContent = nombreContribuyente || 'N/A';
        document.getElementById('catDireccion').textContent = selectedPredioData.direccion || 'N/A';
        document.getElementById('catReferencia').textContent = selectedPredioData.referencia || 'N/A';
      } else {
        
        document.getElementById('catContribuyente').textContent = nombreContribuyente || 'N/A';
        document.getElementById('catDireccion').textContent = 'N/A';
        document.getElementById('catReferencia').textContent = 'N/A';
      }
      
      modalCrearCategorizacion.classList.add('active');
    });
  }
  
  if (btnClonarCategorizacion && modalClonarCategorizacion) {
    btnClonarCategorizacion.addEventListener('click', function() {
      if (!selectedPredioId) {
        alert('Por favor, seleccione un predio primero');
        return;
      }
      
      
      const hasCategorizaciones = document.querySelectorAll('#categorizacionesTableBody tr').length > 1;
      if (!hasCategorizaciones) {
        alert('No hay categorizaciones para clonar');
        return;
      }
      
      modalClonarCategorizacion.classList.add('active');
    });
  }
  
  
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
  

if (formCrearCategorizacion) {
    
    const inputs = formCrearCategorizacion.querySelectorAll('input[type="number"], input[type="date"], select');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            validarCampoEnTiempoReal(this);
        });
        input.addEventListener('change', function() {
            validarCampoEnTiempoReal(this);
        });
    });
    
    
    const selects = formCrearCategorizacion.querySelectorAll('.select-categoria, .select-exoneracion');
    selects.forEach(select => {
        select.addEventListener('change', function() {
            
            if (this.value) {
                this.style.borderColor = '#3498db';
                this.style.fontWeight = '600';
            }
        });
    });
    
    
    const mesCheckboxes = formCrearCategorizacion.querySelectorAll('.mes-checkbox');
    mesCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            validarMesesSeleccionados();
        });
    });
    
    formCrearCategorizacion.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        if (!selectedPredioId) {
            alert('❌ Error: No hay predio seleccionado');
            return;
        }
        
        
        const mesesSeleccionados = formCrearCategorizacion.querySelectorAll('.mes-checkbox:checked').length;
        if (mesesSeleccionados === 0) {
            alert('❌ Error: Debe seleccionar al menos un mes');
            return;
        }
        
        const formData = new FormData(this);
        
        
        const checkboxToInt = (value) => value === 'on' ? 1 : 0;
        
        const toInt = (name) => {
          const v = formData.get(name);
          return v === null || v === '' ? null : parseInt(v, 10);
        };

        const toFloat = (name, def = 0) => {
          const v = formData.get(name);
          return v === null || v === '' ? def : parseFloat(v);
        };

        const data = {
          id_contribuyente: idContribuyente,
          id_predio: selectedPredioId,
          anio: parseInt(formData.get('anio')) || new Date().getFullYear(),
          item: parseInt(formData.get('item')) || 1,
          frentera_metros: toFloat('frentera_metros', 0),
          frecuencia_barrido: toInt('frecuencia_barrido') || 1,
          nro_habitantes: toInt('nro_habitantes') || 1,
          area_construida: toFloat('area_construida', 0),
          area_terreno: toFloat('area_terreno', 0),
          distancia_a_parque: toFloat('distancia_a_parque', 1000),
          tiene_licencia: toInt('tiene_licencia') || 0,
          porcentaje_inseguridad: toFloat('porcentaje_inseguridad', 0),
          
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
          
          id_tipo_beneficio_limpieza_publica: toInt('id_tipo_beneficio_limpieza_publica'),
          id_tipo_beneficio_parques_jardines: toInt('id_tipo_beneficio_parques_jardines'),
          id_tipo_beneficio_relleno_sanitario: toInt('id_tipo_beneficio_relleno_sanitario'),
          id_tipo_beneficio_serenazgo: toInt('id_tipo_beneficio_serenazgo'),
          
          exoneracion_limpieza_publica: toInt('exoneracion_limpieza_publica'),
          exoneracion_parques_jardines: toInt('exoneracion_parques_jardines'),
          exoneracion_relleno_sanitario: toInt('exoneracion_relleno_sanitario'),
          exoneracion_serenazgo: toInt('exoneracion_serenazgo')
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
            
            console.log('[ARBITRIOS] Response status:', response.status);
            console.log('[ARBITRIOS] Response ok:', response.ok);
            
            if (!response.ok) {
                throw new Error(`Error HTTP: ${response.status}`);
            }
            
            const responseText = await response.text();
            console.log('[ARBITRIOS] Response text:', responseText);
            
            let result;
            try {
                result = JSON.parse(responseText);
            } catch (parseError) {
                console.error('[ARBITRIOS] Error al parsear JSON:', parseError);
                console.error('[ARBITRIOS] Texto recibido:', responseText);
                throw new Error('Respuesta inválida del servidor');
            }
            
            console.log('[ARBITRIOS] Respuesta del servidor:', result);
            
            if (result.success) {
                alert('✅ Categorización creada correctamente');
                modalCrearCategorizacion.classList.remove('active');
                modalCrearCategorizacion.style.display = 'none';
                cargarCategorizacionesPredio(selectedPredioId);
                formCrearCategorizacion.reset();
            } else {
                alert('❌ Error: ' + (result.error || 'Error desconocido'));
            }
        } catch (error) {
            console.error('[ARBITRIOS] Error al crear categorización:', error);
            alert('❌ Error al conectar con el servidor: ' + error.message);
        }
    });
}
  
  
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
  
  
  async function abrirModalEditarCategorizacion(idDetalle) {
    const modal = document.getElementById('modalEditarCategorizacion');
    const form = document.getElementById('formEditarCategorizacion');
    if (!modal || !form) throw new Error('Modal de edición no encontrado');

    
    form.reset();
    
    modal.classList.add('active');

    try {
      const resp = await fetch(`index.php?c=arbitrios&m=getCategorizacionDetalle&id_detalle=${idDetalle}`);
      const result = await resp.json();
      if (!result.success) throw new Error(result.error || 'Error al obtener detalle');
      const d = result.data;

      
      document.getElementById('editCatIdDetalle').value = d.id_arbitrio_detalle;
      document.getElementById('editCatAnio').value = d.anio || new Date().getFullYear();
      document.getElementById('editCatItem').value = d.item || 1;

      
      const setMes = (id, val) => { const el = document.getElementById(id); if (el) el.checked = (parseInt(val, 10) === 1); };
      setMes('editMesEnero', d.enero);
      setMes('editMesFebrero', d.febrero);
      setMes('editMesMarzo', d.marzo);
      setMes('editMesAbril', d.abril);
      setMes('editMesMayo', d.mayo);
      setMes('editMesJunio', d.junio);
      setMes('editMesJulio', d.julio);
      setMes('editMesAgosto', d.agosto);
      setMes('editMesSeptiembre', d.septiembre);
      setMes('editMesOctubre', d.octubre);
      setMes('editMesNoviembre', d.noviembre);
      setMes('editMesDiciembre', d.diciembre);

      
      const setVal = (id, val) => { const el = document.getElementById(id); if (el) el.value = (val ?? ''); };
      setVal('editCatFrentera', d.frentera_metros);
      setVal('editCatHabitantes', d.nro_habitantes);
      setVal('editCatFrecuencia', d.frecuencia_barrido);
      setVal('editCatAreaConstruida', d.area_construida);
      setVal('editCatAreaTerreno', d.area_terreno);
      setVal('editCatInseguridad', d.porcentaje_inseguridad);
      setVal('editCatDistanciaParque', d.distancia_a_parque);
      const lic = document.getElementById('editCatLicencia');
      if (lic) lic.value = (parseInt(d.tiene_licencia ?? 0, 10)).toString();

      
      const setSelect = (id, val) => { const el = document.getElementById(id); if (el && val != null) el.value = String(val); };
      setSelect('editCatLP', d.id_tipo_beneficio_limpieza_publica);
      setSelect('editCatPJ', d.id_tipo_beneficio_parques_jardines);
      setSelect('editCatRS', d.id_tipo_beneficio_relleno_sanitario);
      setSelect('editCatSE', d.id_tipo_beneficio_serenazgo);
      
      const setSelectNull = (id, val) => { const el = document.getElementById(id); if (el) el.value = (val == null ? '' : String(val)); };
      setSelectNull('editExLP', d.id_exoneracion_limpieza_publica);
      setSelectNull('editExPJ', d.id_exoneracion_parques_jardines);
      setSelectNull('editExRS', d.id_exoneracion_relleno_sanitario);
      setSelectNull('editExSE', d.id_exoneracion_serenazgo);

      
      modal.classList.add('active');
    } catch (e) {
      modal.classList.remove('active');
      throw e;
    }
  }

  
  const btnCerrarEditarCat = document.getElementById('btnCerrarEditarCat');
  const btnCancelarEditarCat = document.getElementById('btnCancelarEditarCat');
  const modalEditarCategorizacion = document.getElementById('modalEditarCategorizacion');
  if (btnCerrarEditarCat) btnCerrarEditarCat.addEventListener('click', ()=> modalEditarCategorizacion?.classList.remove('active'));
  if (btnCancelarEditarCat) btnCancelarEditarCat.addEventListener('click', ()=> modalEditarCategorizacion?.classList.remove('active'));

  
  const formEditarCategorizacion = document.getElementById('formEditarCategorizacion');
  if (formEditarCategorizacion) {
    formEditarCategorizacion.addEventListener('submit', async function(e) {
      e.preventDefault();
      const fd = new FormData(this);
      const toInt = (name) => {
        const v = fd.get(name);
        return v === null || v === '' ? null : parseInt(v, 10);
      };
      const toFloat = (name, def = 0) => {
        const v = fd.get(name);
        return v === null || v === '' ? def : parseFloat(v);
      };
      const cbInt = (id) => document.getElementById(id)?.checked ? 1 : 0;

      const payload = {
        id_arbitrio_detalle: toInt('id_arbitrio_detalle'),
        anio: toInt('anio') ?? new Date().getFullYear(),
        item: toInt('item') ?? 1,
        frentera_metros: toFloat('frentera_metros', 0),
        frecuencia_barrido: toInt('frecuencia_barrido') ?? 1,
        nro_habitantes: toInt('nro_habitantes') ?? 1,
        area_construida: toFloat('area_construida', 0),
        area_terreno: toFloat('area_terreno', 0),
        distancia_a_parque: toFloat('distancia_a_parque', 0),
        tiene_licencia: toInt('tiene_licencia') ?? 0,
        porcentaje_inseguridad: toFloat('porcentaje_inseguridad', 0),
        
        enero: cbInt('editMesEnero'),
        febrero: cbInt('editMesFebrero'),
        marzo: cbInt('editMesMarzo'),
        abril: cbInt('editMesAbril'),
        mayo: cbInt('editMesMayo'),
        junio: cbInt('editMesJunio'),
        julio: cbInt('editMesJulio'),
        agosto: cbInt('editMesAgosto'),
        septiembre: cbInt('editMesSeptiembre'),
        octubre: cbInt('editMesOctubre'),
        noviembre: cbInt('editMesNoviembre'),
        diciembre: cbInt('editMesDiciembre'),
        
        id_tipo_beneficio_limpieza_publica: toInt('id_tipo_beneficio_limpieza_publica') ?? toInt('id_tipo_beneficio_limpieza_publica'),
        id_tipo_beneficio_parques_jardines: toInt('id_tipo_beneficio_parques_jardines'),
        id_tipo_beneficio_relleno_sanitario: toInt('id_tipo_beneficio_relleno_sanitario'),
        id_tipo_beneficio_serenazgo: toInt('id_tipo_beneficio_serenazgo'),
        
        exoneracion_limpieza_publica: toInt('exoneracion_limpieza_publica'),
        exoneracion_parques_jardines: toInt('exoneracion_parques_jardines'),
        exoneracion_relleno_sanitario: toInt('exoneracion_relleno_sanitario'),
        exoneracion_serenazgo: toInt('exoneracion_serenazgo'),
      };

      try {
        const resp = await fetch('index.php?c=arbitrios&m=actualizarCategorizacion', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload)
        });
        const resText = await resp.text();
        let res;
        try { res = JSON.parse(resText); } catch(_){ throw new Error('Respuesta inválida'); }
        if (!res.success) throw new Error(res.error || 'Error al actualizar');
        alert('✅ Categorización actualizada correctamente');
        modalEditarCategorizacion.classList.remove('active');
        if (selectedPredioId) cargarCategorizacionesPredio(selectedPredioId);
      } catch (err) {
        console.error('[ARBITRIOS] Error actualizar:', err);
        alert('❌ ' + err.message);
      }
    });
  }
  
  
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

  
  if (formAgregarPredio) {
    console.log('[ARBITRIOS] Agregando listener al formulario');
    formAgregarPredio.addEventListener('submit', async function(event) {
      event.preventDefault();

      const predioId = document.getElementById('predioId').value;
      if (!predioId) {
        alert('❌ Por favor, selecciona un predio de la lista');
        return;
      }

      const estado = document.getElementById('estado').value;
      const referencia = document.getElementById('referencia').value;
      
      if (!estado) {
        alert('❌ Debe seleccionar un Estado válido');
        return;
      }
      
      if (!referencia || referencia === '' || referencia === 'undefined') {
        alert('❌ Debe seleccionar una Referencia / Origen válida');
        return;
      }

      const formData = {
        id_contribuyente: document.querySelector('input[name="id_contribuyente"]').value,
        id_predio: predioId,
        estado: estado,
        id_tipo_registro_origen: parseInt(referencia, 10),
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
          alert('✅ Predio agregado correctamente');
          cerrarModal();
          
          window.location.reload();
        } else {
          alert('❌ Error: ' + result.error);
        }
      } catch (error) {
        console.error('[ARBITRIOS] Error al agregar predio:', error);
        alert('❌ Error al conectar con el servidor: ' + error.message);
      }
    });
  } else {
    console.error('[ARBITRIOS] ERROR: No se encontró formAgregarPredio');
  }

  
  const modalImportar = document.getElementById('modalImportar');
  
  
  const btnImportarPredios = document.querySelector('.btn-secondary');
  if (btnImportarPredios && modalImportar) {
    btnImportarPredios.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      console.log('[ARBITRIOS] Abriendo modal de importación...');
      modalImportar.style.display = 'flex';
      modalImportar.classList.add('active');
    });
  }
  
  
  const btnCerrarImportarPredios = document.getElementById('btnCerrarImportarPredios');
  const btnCancelarImportarPredios = document.getElementById('btnCancelarImportarPredios');
  
  if (btnCerrarImportarPredios && modalImportar) {
    btnCerrarImportarPredios.addEventListener('click', () => {
      modalImportar.style.display = 'none';
      modalImportar.classList.remove('active');
    });
  }
  
  if (btnCancelarImportarPredios && modalImportar) {
    btnCancelarImportarPredios.addEventListener('click', () => {
      modalImportar.style.display = 'none';
      modalImportar.classList.remove('active');
    });
  }
  
  if (modalImportar) {
    modalImportar.addEventListener('click', (e) => {
      if (e.target === modalImportar) {
        modalImportar.style.display = 'none';
        modalImportar.classList.remove('active');
      }
    });
  }

  
  setupImportModalFunctionality();

  
  console.log('[ARBITRIOS] Llamando a setupTableActions()...');
  
  setTimeout(function() {
    setupTableActions();
  }, 50);
  
  console.log('[ARBITRIOS] === FIN INICIALIZACIÓN ARBITRIOS ===');
  
  
  setupProcesarCtacte();

  
  setupBadgeSeleccionPredios();
}

function setupProcesarCtacte() {
  console.log('[ARBITRIOS] Inicializando procesar cuenta corriente...');
  
  const modalProcesarCtacte = document.getElementById('modalProcesarCtacte');
  const btnActualizarCtacte = document.getElementById('btnActualizarCtacte');
  const btnCerrarProcesarCtacte = document.getElementById('btnCerrarProcesarCtacte');
  const btnCancelarProcesarCtacte = document.getElementById('btnCancelarProcesarCtacte');
  const formProcesarCtacte = document.getElementById('formProcesarCtacte');
  const btnProcesarCtacte = document.getElementById('btnProcesarCtacte');
  const fechaVencimientoInput = document.getElementById('fechaVencimiento');

  
  const obtenerFechaFutura = (dias = 30) => {
    const fecha = new Date();
    fecha.setDate(fecha.getDate() + dias);
    const año = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, '0');
    const dia = String(fecha.getDate()).padStart(2, '0');
    return `${año}-${mes}-${dia}`;
  };

  
  if (!modalProcesarCtacte) {
    console.error('[ARBITRIOS] ERROR: No se encuentra el modal modalProcesarCtacte');
    return;
  }

  
  const btnVerCtacte = document.getElementById('btnVerCtacte');
  if (btnVerCtacte) {
    btnVerCtacte.addEventListener('click', function(e) {
      e.preventDefault();
      console.log('[ARBITRIOS] Cambianado a tab Estado de Cuenta');
      if (typeof switchTab === 'function') {
        switchTab('cuenta-corriente');
      }
    });
  }
  
  
  if (btnActualizarCtacte) {
    
    btnActualizarCtacte.onclick = null;
    
    btnActualizarCtacte.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      
      console.log('[ARBITRIOS] Botón "Actualizar Cuenta Corriente" CLICKEADO');
      
      
      const prediosSeleccionados = Array.from(document.querySelectorAll('.predio-checkbox:checked'))
        .map(cb => cb.getAttribute('data-predio-id'))
        .filter(Boolean);

      
      const prediosUnicos = Array.from(new Set(prediosSeleccionados));
      sessionStorage.removeItem('prediosProcesarCtacte');

      if (prediosUnicos.length === 0) {
        alert('❌ Marca al menos un predio para procesar su cuenta corriente.');
        return;
      }

      console.log('[ARBITRIOS] Predios seleccionados (usuario):', prediosUnicos);

      
      sessionStorage.setItem('prediosProcesarCtacte', JSON.stringify(prediosUnicos));
      
      
      prediosUnicos.forEach(id => {
        const checkbox = document.querySelector(`.predio-checkbox[data-predio-id="${id}"]`);
        if (checkbox) {
          checkbox.checked = true;
        }
      });
      
      
      if (fechaVencimientoInput) {
        fechaVencimientoInput.value = obtenerFechaFutura(30);
        console.log('[ARBITRIOS] Fecha vencimiento establecida:', fechaVencimientoInput.value);
      }
      
      
      modalProcesarCtacte.style.display = 'flex';
      modalProcesarCtacte.classList.add('active');
      document.body.classList.add('modal-open'); 
      console.log('[ARBITRIOS] Modal mostrado correctamente');
    });
  } else {
    console.error('[ARBITRIOS] ERROR: No se encuentra btnActualizarCtacte');
  }

  
  const cerrarModal = () => {
    modalProcesarCtacte.style.display = 'none';
    modalProcesarCtacte.classList.remove('active');
    document.body.classList.remove('modal-open');
    console.log('[ARBITRIOS] Modal cerrado');
  };

  if (btnCerrarProcesarCtacte) {
    btnCerrarProcesarCtacte.onclick = cerrarModal;
  }
  
  if (btnCancelarProcesarCtacte) {
    btnCancelarProcesarCtacte.onclick = cerrarModal;
  }
  
  
  modalProcesarCtacte.addEventListener('click', function(event) {
    if (event.target === modalProcesarCtacte) {
      cerrarModal();
    }
  });

  
  if (formProcesarCtacte) {
    formProcesarCtacte.addEventListener('submit', async function(e) {
      e.preventDefault();
      
      
      const prediosSeleccionados = JSON.parse(sessionStorage.getItem('prediosProcesarCtacte') || '[]');
      if (prediosSeleccionados.length === 0) {
        alert('No hay predios seleccionados');
        return;
      }

      const idContribuyente = document.getElementById('idContribuyente')?.value;
      if (!idContribuyente) {
        alert('No se encontró el contribuyente en pantalla');
        return;
      }

      
      const tributosSeleccionados = [];
      document.querySelectorAll('input[name="tributos[]"]:checked').forEach(cb => {
        tributosSeleccionados.push(parseInt(cb.value));
      });

      if (tributosSeleccionados.length === 0) {
        alert('Seleccione al menos un tributo');
        return;
      }

      
      const anioDesde = parseInt(document.getElementById('anioDesde').value);
      const anioHasta = parseInt(document.getElementById('anioHasta').value);
      
      if (anioDesde > anioHasta) {
        alert('El año "Desde" no puede ser mayor al año "Hasta"');
        return;
      }

      
      const originalText = btnProcesarCtacte.innerHTML;
      btnProcesarCtacte.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Procesando...';
      btnProcesarCtacte.disabled = true;

      try {
        
        const data = {
          predios: prediosSeleccionados,
          anio_desde: anioDesde,
          anio_hasta: anioHasta,
          fecha_vencimiento: fechaVencimientoInput ? fechaVencimientoInput.value : obtenerFechaFutura(30),
          tributos: tributosSeleccionados,
          id_contribuyente: idContribuyente
        };

        console.log('[ARBITRIOS] Enviando datos al servidor:', data);
        
        const response = await fetch('index.php?c=arbitrios&m=procesarCuentaCorriente', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(data)
        });

        const result = await response.json();
        console.log('[ARBITRIOS] Resultado del servidor:', result);
        
        if (result.success) {
          
          mostrarResultadosProceso(result);
          document.getElementById('resultadoProceso').style.display = 'block';
          
          
          if (result.estadisticas && result.estadisticas.procesados > 0) {
            alert(`✅ PROCESO EXITOSO\n\nPredios procesados: ${result.estadisticas.procesados}\nMonto total: S/. ${result.total_procesado.toFixed(2)}`);
          }
        } else {
          alert('Error: ' + result.error);
        }
      } catch (error) {
        console.error('[ARBITRIOS] Error al procesar:', error);
        alert('Error de conexión: ' + error.message);
      } finally {
        btnProcesarCtacte.innerHTML = originalText;
        btnProcesarCtacte.disabled = false;
      }
    });
  }
  
  console.log('[ARBITRIOS] setupProcesarCtacte() configurado correctamente');
}

function setupBadgeSeleccionPredios() {
  const btnActualizarCtacte = document.getElementById('btnActualizarCtacte');
  if (!btnActualizarCtacte) return;
  let badge = document.getElementById('badgePrediosSeleccionados');
  if (!badge) {
    badge = document.createElement('span');
    badge.id = 'badgePrediosSeleccionados';
    badge.style.background = '#2196F3';
    badge.style.color = '#fff';
    badge.style.borderRadius = '12px';
    badge.style.padding = '4px 10px';
    badge.style.fontSize = '12px';
    badge.style.marginLeft = '10px';
    badge.style.verticalAlign = 'middle';
    badge.style.display = 'none';
    btnActualizarCtacte.parentNode.insertBefore(badge, btnActualizarCtacte.nextSibling);
  }
  actualizarBadgeSeleccionPredios();
}

function actualizarBadgeSeleccionPredios() {
  const badge = document.getElementById('badgePrediosSeleccionados');
  if (!badge) return;
  const count = document.querySelectorAll('.predio-checkbox:checked').length;
  const btn = document.getElementById('btnActualizarCtacte');
  if (count > 0) {
    badge.textContent = `${count} predio${count > 1 ? 's' : ''} marcado${count > 1 ? 's' : ''}`;
    badge.title = 'Predios que se procesarán en la cuenta corriente';
    badge.style.display = 'inline-block';
    if (btn) {
      btn.disabled = false;
      btn.style.opacity = '';
      btn.style.cursor = 'pointer';
    }
  } else {
    badge.style.display = 'none';
    if (btn) {
      btn.disabled = true;
      btn.style.opacity = '0.6';
      btn.style.cursor = 'not-allowed';
    }
  }
}

function mostrarResultadosProceso(resultado) {
  const cuerpoResultados = document.getElementById('cuerpoResultados');
  const totalProcesado = document.getElementById('totalProcesado');
  const totalRegistros = document.getElementById('totalRegistros');

  if (!cuerpoResultados) {
    console.warn('[ARBITRIOS] No se encontró cuerpo de resultados');
    return;
  }

  let html = '';
  let total = 0;
  let registros = 0;

  if (resultado.detalles && resultado.detalles.length > 0) {
    resultado.detalles.forEach(detalle => {
      const estadoClass = detalle.estado && detalle.estado.includes('✓') ? 'estado-success' : 'estado-error';
      
      html += `
        <tr>
          <td>${detalle.tributo || 'Arbitrios'}</td>
          <td>${detalle.predio || detalle.predio_codigo || ''}</td>
          <td>${detalle.codigo || ''}</td>
          <td>${detalle.fecha_vencimiento || ''}</td>
          <td>S/. ${parseFloat(detalle.monto_base || 0).toFixed(2)}</td>
          <td>S/. ${parseFloat(detalle.interes || 0).toFixed(2)}</td>
          <td>S/. ${parseFloat(detalle.mora || 0).toFixed(2)}</td>
          <td>S/. ${parseFloat(detalle.total || 0).toFixed(2)}</td>
          <td class="${estadoClass}">${detalle.estado || 'Error'}</td>
        </tr>
      `;

      if (detalle.estado && detalle.estado.includes('✓')) {
        total += parseFloat(detalle.total || 0);
      }
      registros++;
    });
  } else {
    html = `<tr><td colspan="9" class="text-center">No se procesaron registros</td></tr>`;
  }

  cuerpoResultados.innerHTML = html;
  if (totalProcesado) totalProcesado.textContent = `S/. ${total.toFixed(2)}`;
  if (totalRegistros) totalRegistros.textContent = registros;
}

function exportarResultadosExcel() {
  const tabla = document.getElementById('tablaResultados');
  if (!tabla) {
    alert('No hay datos para exportar');
    return;
  }

  
  if (typeof XLSX === 'undefined') {
    alert('La librería para exportar Excel no está cargada');
    return;
  }

  const ws = XLSX.utils.table_to_sheet(tabla);
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, 'Resultados');

  const fecha = new Date().toISOString().split('T')[0];
  XLSX.writeFile(wb, `resultados_cuenta_corriente_${fecha}.xlsx`);
}

async function generarRecibosCaja() {
  const prediosSeleccionados = JSON.parse(sessionStorage.getItem('prediosProcesarCtacte') || '[]');
  
  if (prediosSeleccionados.length === 0) {
    alert('No hay predios seleccionados para generar recibos');
    return;
  }

  if (!confirm(`¿Generar recibos para ${prediosSeleccionados.length} predio(s) en el módulo de caja?`)) {
    return;
  }

  try {
    
    const idCajero = 1; 
    
    const response = await fetch('index.php?c=arbitrios&m=generarRecibosCaja', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        predios: prediosSeleccionados,
        id_cajero: idCajero,
        fecha_vencimiento: document.getElementById('fechaVencimiento').value
      })
    });

    const result = await response.json();
    
    if (result.success) {
      alert(`Se generaron ${result.recibos_generados} recibos correctamente\nTotal: S/. ${result.total_generado.toFixed(2)}`);
      
      
      if (confirm('¿Desea ver los recibos generados en el módulo de caja?')) {
        window.open('index.php?c=caja&m=index', '_blank');
      }
    } else {
      alert('Error: ' + result.error);
    }
  } catch (error) {
    console.error('[ARBITRIOS] Error al generar recibos:', error);
    alert('Error de conexión con el módulo de caja');
  }
}

function scrollToElement(elementId) {
  const element = document.getElementById(elementId);
  if (element) {
    element.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
}

function setupTableActions() {
  console.log('[ARBITRIOS] === SETUP TABLE ACTIONS ===');
  
  const tabla = document.querySelector('.arb-predios-table');
  console.log('[ARBITRIOS] Tabla encontrada:', tabla ? 'SÍ' : 'NO');
  
  if (!tabla) {
    console.warn('[ARBITRIOS] No hay tabla de predios en la página');
    return;
  }

  
  let botonesVer = document.querySelectorAll('table.arb-predios-table .btn-ver');
  console.log('[ARBITRIOS] Botones Ver encontrados:', botonesVer.length);
  
  botonesVer.forEach((btn, idx) => {
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      console.log('[ARBITRIOS] *** CLICK VER PREDIO #' + idx + ' ***');
      
      const fila = this.closest('tr');
      if (!fila) {
        console.error('[ARBITRIOS] ERROR: No se encontró fila');
        alert('Error: No se encontró la fila del predio');
        return;
      }
      
      try {
        const predioId = this.dataset.predioId;
        const contribuyenteId = this.dataset.contribuyenteId;
        
        
        
        const estado = fila.querySelector('td:nth-child(2)')?.textContent.trim() || '';
        const codigo = fila.querySelector('td:nth-child(3)')?.textContent.trim() || '';
        const direccion = fila.querySelector('td:nth-child(4)')?.textContent.trim() || '';
        const referencia = fila.querySelector('td:nth-child(5)')?.textContent.trim() || '';
        const usuario = fila.querySelector('td:nth-child(6)')?.textContent.trim() || '';
        const fechaReg = fila.querySelector('td:nth-child(10)')?.textContent.trim() || '';
        
        
        const contenido = document.getElementById('verPredioContent');
        contenido.innerHTML = `
          <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px;">
            <div><strong>Estado:</strong><br/><span class="badge badge-${estado.toLowerCase()}">${estado}</span></div>
            <div><strong>Código:</strong><br/>${codigo}</div>
            <div><strong>Dirección:</strong><br/>${direccion}</div>
            <div><strong>Referencia/Origen:</strong><br/>${referencia}</div>
            <div><strong>Registrado por:</strong><br/>${usuario}</div>
            <div><strong>Fecha servidor:</strong><br/>${fechaReg}</div>
            <div><strong>ID Predio:</strong><br/>${predioId}</div>
            <div><strong>ID Contribuyente:</strong><br/>${contribuyenteId}</div>
          </div>
        `;
        
        
        const modalVer = document.getElementById('modalVerPredio');
        if (modalVer) {
          modalVer.style.display = 'flex';
          modalVer.classList.add('active');
        }
        
      } catch(err) {
        console.error('[ARBITRIOS] Error al extraer datos:', err);
        alert('Error al extraer datos del predio');
      }
    });
  });

  
  let botonesEditar = document.querySelectorAll('table.arb-predios-table .btn-editar');
  console.log('[ARBITRIOS] Botones Editar encontrados:', botonesEditar.length);
  
  botonesEditar.forEach((btn, idx) => {
    btn.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      console.log('[ARBITRIOS] *** CLICK EDITAR PREDIO #' + idx + ' ***');
      
      const fila = this.closest('tr');
      if (!fila) {
        console.error('[ARBITRIOS] ERROR: No se encontró fila');
        alert('Error: No se encontró la fila del predio');
        return;
      }
      
      try {
        
        const predioId = this.dataset.predioId;
        const contribuyenteId = this.dataset.contribuyenteId;
        const estado = this.dataset.estado;
        const idTipoRegistroOrigen = this.dataset.idTipoRegistroOrigen;
        
        console.log('[ARBITRIOS] Datos extraídos:', { predioId, contribuyenteId, estado, idTipoRegistroOrigen });
        
        
        if (!predioId || !contribuyenteId) {
          console.error('[ARBITRIOS] Faltan datos del predio');
          alert('Error: Faltan datos del predio');
          return;
        }
        
        
        document.getElementById('editPredioId').value = predioId;
        document.getElementById('editContribuyenteId').value = contribuyenteId;
        document.getElementById('editEstado').value = estado || 'activo';
        
        
        const selectRef = document.getElementById('editReferencia');
        if (idTipoRegistroOrigen && selectRef) {
          selectRef.value = idTipoRegistroOrigen;
          if (!selectRef.value) {
            console.warn('[ARBITRIOS] No se encontró option con value:', idTipoRegistroOrigen);
          }
        }
        
        
        const modalEditar = document.getElementById('modalEditarPredio');
        if (modalEditar) {
          modalEditar.style.display = 'flex';
          modalEditar.classList.add('active');
        }
        
      } catch(err) {
        console.error('[ARBITRIOS] Error al preparar edición:', err);
        alert('Error al preparar la edición del predio');
      }
    });
  });

  
  let botonesEliminar = document.querySelectorAll('table.arb-predios-table .btn-eliminar');
  console.log('[ARBITRIOS] Botones Eliminar encontrados:', botonesEliminar.length);

  botonesEliminar.forEach((btn, idx) => {
      btn.addEventListener('click', async function(e) {
          e.preventDefault();
          e.stopPropagation();
          
          const fila = this.closest('tr');
          const predioId = this.dataset.predioId;
          const contribuyenteId = this.dataset.contribuyenteId; 
          
          console.log('[ARBITRIOS] Datos:', { predioId, contribuyenteId });
          
          if (!fila || !predioId || !contribuyenteId) {
              alert('Error: No se pudo obtener información del predio o contribuyente');
              return;
          }
          
          const codigo = fila.querySelector('td:nth-child(3)').textContent.trim();
          
          if (!confirm(`¿Está seguro de eliminar el predio "${codigo}" de arbitrios?\n\nEsta acción eliminará todas las categorizaciones asociadas.`)) {
              return;
          }
          
          
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
                  
                  fila.remove();
                  console.log('[ARBITRIOS] Predio eliminado correctamente');
                  
                  
                  alert(result.message);
                  
                  
                  const totalFilas = document.querySelectorAll('#prediosTableBody tr').length;
                  if (totalFilas === 0) {
                      document.querySelector('#prediosTableBody').innerHTML = 
                          '<tr><td colspan="11" class="text-center">No hay predios registrados para este contribuyente.</td></tr>';
                  }
                  
                  
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

async function buscarPrediosReales(searchTerm) {
  const predioList = document.getElementById('predioList');
  
  if (!predioList) return;
  
  
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
  
  
  setTimeout(() => {
    setupImportModalEvents(modal);
  }, 100);
  
  return modal;
}

function setupImportModalEvents(modal) {
  const modalImportar = modal;
  const btnCerrarImport = modal.querySelector('#btnCerrarImport');
  const btnCancelImport = modal.querySelector('#btnCancelImport');
  const importOptions = modal.querySelectorAll('.import-option');
  const btnBackToSource = modal.querySelector('#btnBackToSource');
  const selectAllPredios = modal.querySelector('#selectAllPredios');
  const btnImportSelected = modal.querySelector('#btnImportSelected');
  const searchPredios = modal.querySelector('#searchPredios');
  
  
  const urlParams = new URLSearchParams(window.location.search);
  const idContribuyente = urlParams.get('id');
  
  
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
      
      
      modal.querySelector('#step1').classList.remove('active');
      modal.querySelector('#step2').classList.add('active');
    });
  });
  
  
  if (btnBackToSource) {
    btnBackToSource.addEventListener('click', function() {
      modal.querySelector('#step2').classList.remove('active');
      modal.querySelector('#step1').classList.add('active');
      clearPrediosList();
    });
  }
  
  
  if (selectAllPredios) {
    selectAllPredios.addEventListener('change', function() {
      const checkboxes = modal.querySelectorAll('.predio-checkbox');
      checkboxes.forEach(cb => {
        cb.checked = this.checked;
      });
      updateSelectedCount();
    });
  }
  
  
  if (btnImportSelected) {
    btnImportSelected.addEventListener('click', function() {
      importSelectedPredios(idContribuyente);
    });
  }
  
  
  if (searchPredios) {
    searchPredios.addEventListener('input', function() {
      filterPredios(this.value.toLowerCase());
    });
  }
  
  function closeImportModal() {
    modalImportar.classList.remove('active');
    
    modal.querySelector('#step2').classList.remove('active');
    modal.querySelector('#step1').classList.add('active');
    clearPrediosList();
  }
}

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
    console.log('[ARBITRIOS] Loading licencias for contribuyente:', idContribuyente);
    const response = await fetch(`index.php?c=arbitrios&m=getLicencias&id=${idContribuyente}`);
    const result = await response.json();
    console.log('[ARBITRIOS] getLicencias response:', result);
    
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
    console.log('[ARBITRIOS] Loading declaraciones for contribuyente:', idContribuyente);
    const response = await fetch(`index.php?c=arbitrios&m=getDeclaraciones&id=${idContribuyente}`);
    const result = await response.json();
    console.log('[ARBITRIOS] getDeclaraciones response:', result);
    
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

function displayPredios(predios, sourceType) {
  const prediosList = document.querySelector('#prediosList');
  let html = '';
  
  console.log('[ARBITRIOS] displayPredios called:', { count: predios.length, sourceType, sample: predios[0] });
  
  if (!predios || predios.length === 0) {
    html = `
      <tr>
        <td colspan="4" class="text-center empty">
          <i class="fas fa-inbox"></i> No se encontraron predios para importar
        </td>
      </tr>
    `;
  } else {
    predios.forEach((predio, index) => {
      
      const id = predio.id || predio.id_predio;
      const codigo = predio.codigo || predio.codigo_catastral || 'N/A';
      const direccion = predio.direccion || 'Sin dirección';
      const adicional = predio.adicional || '';
      
      html += `
        <tr class="predio-row">
          <td>
            <input type="checkbox" 
                   class="predio-checkbox" 
                   data-id="${id}"
                   data-id_predio="${predio.id_predio}"
                   data-codigo="${codigo}"
                   data-direccion="${direccion}"
                   data-adicional="${adicional}"
                   data-source="${sourceType}">
          </td>
          <td class="predio-codigo">${codigo}</td>
          <td class="predio-direccion">${direccion}</td>
          <td class="predio-adicional">${adicional}</td>
        </tr>
      `;
    });
  }
  
  prediosList.innerHTML = html;
  
  
  const checkboxes = prediosList.querySelectorAll('.predio-checkbox');
  checkboxes.forEach(cb => {
    cb.addEventListener('change', updateSelectedCount);
  });
  
  
  const selectAll = document.querySelector('#selectAllPredios');
  if (selectAll) selectAll.checked = false;
  
  updateSelectedCount();
}

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
  
  
  const allCheckboxes = document.querySelectorAll('.predio-checkbox');
  const selectAll = document.querySelector('#selectAllPredios');
  if (selectAll && allCheckboxes.length > 0) {
    selectAll.checked = count === allCheckboxes.length;
    selectAll.indeterminate = count > 0 && count < allCheckboxes.length;
  }
}

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
  
  
  const sourceType = checkboxes[0]?.dataset.source || 'licencias';
  const sourceName = sourceType === 'licencias' ? 'Licencias de Funcionamiento' : 'Declaraciones Juradas';
  
  
  const confirmMessage = `¿Está seguro de importar ${selectedPredios.length} predio(s) desde ${sourceName} a arbitrios?\n\n` +
                        'Nota: Solo se importarán los predios que no estén ya registrados.';
  
  if (!confirm(confirmMessage)) {
    return;
  }
  
  
  await executeImport(idContribuyente, selectedPredios, sourceType);
}

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
    
    
    const btnCloseImport = step2.querySelector('#btnCloseImport');
    if (btnCloseImport) {
      btnCloseImport.addEventListener('click', () => {
        modal.classList.remove('active');
        
        modal.querySelector('#step2').classList.remove('active');
        modal.querySelector('#step1').classList.add('active');
        clearPrediosList();
        
        
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

function clearPrediosList() {
  const prediosList = document.querySelector('#prediosList');
  if (prediosList) prediosList.innerHTML = '';
  
  
  updateSelectedCount();
  
  
  const searchInput = document.querySelector('#searchPredios');
  if (searchInput) searchInput.value = '';
}

document.addEventListener('DOMContentLoaded', function() {
  console.log('[ARBITRIOS] Configurando event listeners para modales editar/ver predio');
  
  
  const btnCerrarVerPredio = document.getElementById('btnCerrarVerPredio');
  const btnCerrarVerPredioBtn = document.getElementById('btnCerrarVerPredioBtn');
  const modalVerPredio = document.getElementById('modalVerPredio');
  
  if (btnCerrarVerPredio) {
    btnCerrarVerPredio.addEventListener('click', () => {
      modalVerPredio.style.display = 'none';
      modalVerPredio.classList.remove('active');
    });
  }
  
  if (btnCerrarVerPredioBtn) {
    btnCerrarVerPredioBtn.addEventListener('click', () => {
      modalVerPredio.style.display = 'none';
      modalVerPredio.classList.remove('active');
    });
  }
  
  
  if (modalVerPredio) {
    modalVerPredio.addEventListener('click', (e) => {
      if (e.target === modalVerPredio) {
        modalVerPredio.style.display = 'none';
        modalVerPredio.classList.remove('active');
      }
    });
  }
  
  
  const btnCerrarEditarPredio = document.getElementById('btnCerrarEditarPredio');
  const btnCancelarEditarPredio = document.getElementById('btnCancelarEditarPredio');
  const modalEditarPredio = document.getElementById('modalEditarPredio');
  
  if (btnCerrarEditarPredio) {
    btnCerrarEditarPredio.addEventListener('click', () => {
      modalEditarPredio.style.display = 'none';
      modalEditarPredio.classList.remove('active');
    });
  }
  
  if (btnCancelarEditarPredio) {
    btnCancelarEditarPredio.addEventListener('click', () => {
      modalEditarPredio.style.display = 'none';
      modalEditarPredio.classList.remove('active');
    });
  }
  
  
  if (modalEditarPredio) {
    modalEditarPredio.addEventListener('click', (e) => {
      if (e.target === modalEditarPredio) {
        modalEditarPredio.style.display = 'none';
        modalEditarPredio.classList.remove('active');
      }
    });
  }
  
  
  const formEditarPredio = document.getElementById('formEditarPredio');
  if (formEditarPredio) {
    formEditarPredio.addEventListener('submit', async function(e) {
      e.preventDefault();
      console.log('[ARBITRIOS] *** SUBMIT FORMULARIO EDITAR PREDIO ***');
      
      const formData = new FormData(this);
      
      
      const idPredio = formData.get('id_predio');
      const idContribuyente = formData.get('id_contribuyente');
      const estado = formData.get('estado');
      const idTipoRegistro = formData.get('id_tipo_registro_origen');
      
      console.log('[ARBITRIOS] Datos del formulario:', {
        idPredio,
        idContribuyente,
        estado,
        idTipoRegistro
      });
      
      
      if (!idPredio || idPredio === '' || idPredio === 'undefined') {
        alert('❌ Error: ID de predio no válido');
        return;
      }
      
      if (!idContribuyente || idContribuyente === '' || idContribuyente === 'undefined') {
        alert('❌ Error: ID de contribuyente no válido');
        return;
      }
      
      if (!estado || estado === '' || estado === 'undefined') {
        alert('❌ Error: Debe seleccionar un estado válido');
        return;
      }
      
      if (!idTipoRegistro || idTipoRegistro === '' || idTipoRegistro === 'undefined') {
        alert('❌ Error: Debe seleccionar una Referencia / Origen válida');
        return;
      }
      
      
      const idPredioInt = parseInt(idPredio, 10);
      const idContribuyenteInt = parseInt(idContribuyente, 10);
      const idTipoRegistroInt = parseInt(idTipoRegistro, 10);
      
      if (isNaN(idPredioInt) || idPredioInt <= 0) {
        alert('❌ Error: ID de predio debe ser un número válido');
        return;
      }
      
      if (isNaN(idContribuyenteInt) || idContribuyenteInt <= 0) {
        alert('❌ Error: ID de contribuyente debe ser un número válido');
        return;
      }
      
      if (isNaN(idTipoRegistroInt) || idTipoRegistroInt <= 0) {
        alert('❌ Error: ID de tipo registro origen debe ser un número válido');
        return;
      }
      
      const data = {
        id_predio: idPredioInt,
        id_contribuyente: idContribuyenteInt,
        estado: estado,
        id_tipo_registro_origen: idTipoRegistroInt
      };
      
      console.log('[ARBITRIOS] Datos validados a enviar:', data);
      
      try {
        const response = await fetch('index.php?c=arbitrios&m=actualizarPredio', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(data)
        });
        
        if (!response.ok) {
          throw new Error(`Error HTTP: ${response.status}`);
        }
        
        const result = await response.json();
        console.log('[ARBITRIOS] Resultado:', result);
        
        if (result.success) {
          alert('✅ Predio actualizado correctamente');
          modalEditarPredio.style.display = 'none';
          modalEditarPredio.classList.remove('active');
          
          window.location.reload();
        } else {
          alert('❌ Error: ' + (result.error || 'No se pudo actualizar el predio'));
        }
      } catch (error) {
        console.error('[ARBITRIOS] Error al actualizar:', error);
        alert('Error al conectar con el servidor: ' + error.message);
      }
    });
  }
  
  console.log('[ARBITRIOS] Event listeners configurados correctamente');
});
function setupImportModalFunctionality() {
  console.log('[ARBITRIOS] Configurando funcionalidad del modal de importación...');
  
  const selectImportarDesde = document.getElementById('selectImportarDesde');
  const prediosDisponiblesBody = document.getElementById('prediosDisponiblesBody');
  const selectAllPredios = document.getElementById('selectAllPredios');
  const totalSeleccionados = document.getElementById('totalSeleccionados');
  const btnEjecutarImportar = document.getElementById('btnEjecutarImportar');
  const btnBuscarPredios = document.getElementById('btnBuscarPredios');
  const formImportarPredios = document.getElementById('formImportarPredios');
  
  if (!selectImportarDesde || !prediosDisponiblesBody) {
    console.error('[ARBITRIOS] No se encontraron elementos del modal de importación');
    return;
  }
  
  
  const urlParams = new URLSearchParams(window.location.search);
  const idContribuyente = urlParams.get('id');
  
  if (!idContribuyente) {
    console.error('[ARBITRIOS] No se encontró ID de contribuyente en URL');
    return;
  }
  
  let prediosData = []; 
  
  
  selectImportarDesde.addEventListener('change', async function() {
    const tipoOrigen = this.value;
    console.log('[ARBITRIOS] Cambió select a:', tipoOrigen);
    
    if (!tipoOrigen) {
      prediosDisponiblesBody.innerHTML = '<tr><td colspan="4" style="text-align:center;color:#999;">Seleccione un origen para cargar predios</td></tr>';
      prediosData = [];
      updateSelectionCount();
      return;
    }
    
    
    prediosDisponiblesBody.innerHTML = '<tr><td colspan="4" style="text-align:center;"><i class="fas fa-spinner fa-spin"></i> Cargando predios...</td></tr>';
    
    try {
      let endpoint = '';
      
      
      if (tipoOrigen === 'predio') {
        endpoint = `index.php?c=arbitrios&m=getLicencias&id=${idContribuyente}`;
      } else if (tipoOrigen === 'impuesto_predial') {
        endpoint = `index.php?c=arbitrios&m=getLicencias&id=${idContribuyente}`;
      } else if (tipoOrigen === 'declaracion_jurada') {
        endpoint = `index.php?c=arbitrios&m=getDeclaraciones&id=${idContribuyente}`;
      }
      
      console.log('[ARBITRIOS] Fetching:', endpoint);
      const response = await fetch(endpoint);
      const result = await response.json();
      
      console.log('[ARBITRIOS] Respuesta:', result);
      
      if (result.success && result.data && result.data.length > 0) {
        prediosData = result.data;
        renderPrediosTable(prediosData);
      } else {
        prediosDisponiblesBody.innerHTML = '<tr><td colspan="4" style="text-align:center;color:#999;">No hay predios disponibles para importar</td></tr>';
        prediosData = [];
      }
    } catch (error) {
      console.error('[ARBITRIOS] Error al cargar predios:', error);
      prediosDisponiblesBody.innerHTML = '<tr><td colspan="4" style="text-align:center;color:#dc3545;"><i class="fas fa-exclamation-circle"></i> Error al cargar predios</td></tr>';
      prediosData = [];
    }
    
    updateSelectionCount();
  });
  
  
  function renderPrediosTable(predios) {
    if (!predios || predios.length === 0) {
      prediosDisponiblesBody.innerHTML = '<tr><td colspan="4" style="text-align:center;color:#999;">No hay predios disponibles</td></tr>';
      return;
    }
    
    let html = '';
    predios.forEach((predio, index) => {
      
      const id = predio.id || predio.id_predio;
      const codigo = predio.codigo || predio.codigo_catastral || 'N/A';
      const direccion = predio.direccion || 'Sin dirección';
      const adicional = predio.adicional || '';
      const estado = predio.estado || 'Activo';
      
      html += `
        <tr>
          <td><input type="checkbox" class="predio-checkbox-import" data-index="${index}" data-id="${id}" data-id-predio="${predio.id_predio || id}" data-codigo="${codigo}"></td>
          <td>${codigo}</td>
          <td>${direccion}</td>
          <td>${estado}</td>
        </tr>
      `;
    });
    
    prediosDisponiblesBody.innerHTML = html;
    
    
    document.querySelectorAll('.predio-checkbox-import').forEach(cb => {
      cb.addEventListener('change', updateSelectionCount);
    });
  }
  
  
  function updateSelectionCount() {
    const checked = document.querySelectorAll('.predio-checkbox-import:checked');
    const count = checked.length;
    
    if (totalSeleccionados) {
      totalSeleccionados.textContent = count;
    }
    
    
    if (btnEjecutarImportar) {
      btnEjecutarImportar.disabled = count === 0;
      btnEjecutarImportar.innerHTML = count > 0 
        ? `<i class="fas fa-download"></i> Importar Seleccionados (${count})`
        : '<i class="fas fa-download"></i> Importar Seleccionados';
    }
  }
  
  
  if (selectAllPredios) {
    selectAllPredios.addEventListener('change', function() {
      const checkboxes = document.querySelectorAll('.predio-checkbox-import');
      checkboxes.forEach(cb => {
        cb.checked = this.checked;
      });
      updateSelectionCount();
    });
  }
  
  
  if (btnBuscarPredios) {
    btnBuscarPredios.addEventListener('click', function(e) {
      e.preventDefault();
      const searchTerm = prompt('Ingrese código o dirección a buscar:');
      if (!searchTerm) return;
      
      const filtered = prediosData.filter(p => {
        const codigo = p.codigo || p.codigo_catastral || '';
        const direccion = p.direccion || '';
        return codigo.toLowerCase().includes(searchTerm.toLowerCase()) ||
               direccion.toLowerCase().includes(searchTerm.toLowerCase());
      });
      
      if (filtered.length > 0) {
        renderPrediosTable(filtered);
        alert(`Se encontraron ${filtered.length} predios`);
      } else {
        alert('No se encontraron predios con ese criterio');
      }
    });
  }
  
  
  if (formImportarPredios) {
    formImportarPredios.addEventListener('submit', async function(e) {
      e.preventDefault();
      
      const checkedBoxes = document.querySelectorAll('.predio-checkbox-import:checked');
      
      if (checkedBoxes.length === 0) {
        alert('⚠️ Debe seleccionar al menos un predio para importar');
        return;
      }
      
      const tipoOrigen = selectImportarDesde.value;
      const prediosToImport = [];
      
      checkedBoxes.forEach(cb => {
        prediosToImport.push({
          id_predio: cb.dataset.idPredio || cb.dataset.id,
          codigo: cb.dataset.codigo
        });
      });
      
      
      let tipoFuente = 'licencias'; 
      if (tipoOrigen === 'declaracion_jurada') {
        tipoFuente = 'declaraciones';
      }
      
      if (!confirm(`¿Está seguro de importar ${prediosToImport.length} predio(s)?`)) {
        return;
      }
      
      
      btnEjecutarImportar.disabled = true;
      btnEjecutarImportar.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Importando...';
      
      try {
        const response = await fetch('index.php?c=arbitrios&m=importarPredios', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            id_contribuyente: idContribuyente,
            predios: prediosToImport,
            tipo_fuente: tipoFuente
          })
        });
        
        const result = await response.json();
        console.log('[ARBITRIOS] Resultado de importación:', result);
        
        if (result.success) {
          let mensaje = `✅ Proceso completado:\n\n`;
          mensaje += `• Importados: ${result.importados}\n`;
          mensaje += `• Ya existían: ${result.no_importados}\n`;
          mensaje += `• Total procesados: ${result.total_procesados}`;
          
          if (result.detalles && result.detalles.length > 0) {
            mensaje += `\n\nDetalles:\n` + result.detalles.slice(0, 5).join('\n');
            if (result.detalles.length > 5) {
              mensaje += `\n... y ${result.detalles.length - 5} más`;
            }
          }
          
          alert(mensaje);
          
          
          document.getElementById('modalImportar').style.display = 'none';
          window.location.reload();
        } else {
          alert('❌ Error: ' + (result.error || 'No se pudo completar la importación'));
          btnEjecutarImportar.disabled = false;
          btnEjecutarImportar.innerHTML = '<i class="fas fa-download"></i> Importar Seleccionados';
        }
      } catch (error) {
        console.error('[ARBITRIOS] Error al importar:', error);
        alert('❌ Error de conexión: ' + error.message);
        btnEjecutarImportar.disabled = false;
        btnEjecutarImportar.innerHTML = '<i class="fas fa-download"></i> Importar Seleccionados';
      }
    });
  }
  
  console.log('[ARBITRIOS] Modal de importación configurado correctamente');
}


