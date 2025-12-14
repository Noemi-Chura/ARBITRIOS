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

  console.log('[ARBITRIOS] btnAgregarPredio:', btnAgregarPredio);
  console.log('[ARBITRIOS] modalAgregarPredio:', modalAgregarPredio);
  console.log('[ARBITRIOS] formAgregarPredio:', formAgregarPredio);

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

  console.log('[ARBITRIOS] Llamando a setupTableActions()...');
  
  setTimeout(function() {
    setupTableActions();
  }, 50);
  
  console.log('[ARBITRIOS] === FIN INICIALIZACIÓN ARBITRIOS ===');
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
  
  // Mostrar confirmación
  if (!confirm(`¿Está seguro de importar ${selectedPredios.length} predios a arbitrios?`)) {
    return;
  }
  
  // Simular importación REAL
  await simulateRealImport(idContribuyente, selectedPredios, sourceType);
}

// ============ SIMULAR PROCESO DE IMPORTACIÓN REAL ============
async function simulateRealImport(idContribuyente, predios, sourceType) {
  const modal = document.querySelector('#modalImportarPredios');
  const step2 = modal.querySelector('#step2');
  
  const progressHTML = `
    <div class="import-progress">
      <h3><i class="fas fa-sync fa-spin"></i> Importando predios...</h3>
      <div class="progress-bar">
        <div class="progress-fill" id="progressFill"></div>
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
    
    // Mostrar resultado
    if (result.success) {
      step2.innerHTML = `
        <div class="import-success">
          <i class="fas fa-check-circle fa-4x"></i>
          <h3>¡Importación completada!</h3>
          <p>${result.message}</p>
          ${result.errors && result.errors.length > 0 ? 
            `<div class="import-warnings">
              <p><strong>Advertencias:</strong></p>
              <ul>${result.errors.map(err => `<li>${err}</li>`).join('')}</ul>
            </div>` : ''}
          <div class="success-actions">
            <button class="btn-grabar" id="btnCloseImport">Cerrar</button>
          </div>
        </div>
      `;
    } else {
      step2.innerHTML = `
        <div class="import-error">
          <i class="fas fa-times-circle fa-4x"></i>
          <h3>Error en la importación</h3>
          <p>${result.error}</p>
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
          window.location.reload();
        }
      });
    }
    
  } catch (error) {
    console.error('[ARBITRIOS] Error en importación:', error);
    step2.innerHTML = `
      <div class="import-error">
        <i class="fas fa-times-circle fa-4x"></i>
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

// ============ FUNCIONES EXISTENTES PARA ACCIONES DE TABLA ============
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
    console.log(`[ARBITRIOS] Agregando listener Eliminar #${idx}`, btn);
    btn.addEventListener('click', async function(e) {
      e.preventDefault();
      e.stopPropagation();
      console.log('[ARBITRIOS] *** CLICK ELIMINAR PREDIO #' + idx + ' ***');
      
      const fila = this.closest('tr');
      console.log('[ARBITRIOS] Fila encontrada:', fila ? 'SÍ' : 'NO');
      
      if (!fila) {
        console.error('[ARBITRIOS] ERROR: No se encontró fila (tr) desde botón Eliminar');
        alert('Error: No se encontró la fila del predio');
        return;
      }
      
      try {
        const codigo = fila.querySelector('td:nth-child(2)').textContent.trim();
        if (confirm(`¿Eliminar el predio ${codigo} de arbitrios?`)) {
          // Aquí iría la llamada AJAX para eliminar de la base de datos
          console.log('[ARBITRIOS] Eliminando predio:', codigo);
          
          // Por ahora, solo eliminamos del DOM
          fila.remove();
          alert(`Predio ${codigo} eliminado (demostración)`);
          console.log('[ARBITRIOS] Fila eliminada del DOM');
        }
      } catch(err) {
        console.error('[ARBITRIOS] Error al extraer datos:', err);
        alert('Error al extraer datos del predio');
      }
    });
  });
  
  console.log('[ARBITRIOS] === FIN SETUP TABLE ACTIONS ===');
}