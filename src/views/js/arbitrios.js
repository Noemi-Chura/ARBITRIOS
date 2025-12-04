console.log('[ARBITRIOS] Script cargado. readyState:', document.readyState);

if (document.readyState === 'loading') {
  console.log('[ARBITRIOS] DOM aún cargando, esperando DOMContentLoaded...');
  document.addEventListener('DOMContentLoaded', initializeArbitrios);
} else {
  console.log('[ARBITRIOS] DOM ya listo, inicializando directamente...');
  // Usar setTimeout para asegurar que el DOM esté completamente procesado
  setTimeout(initializeArbitrios, 100);
}

function initializeArbitrios() {
  console.log('[ARBITRIOS] === INICIANDO ARBITRIOS ===');
  
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

  const prediosDatos = [
    { id: 1, codigo: '000001', direccion: 'CESAR VALLEJO calle LAS GRANADAS Mz. F Lt. 01' },
    { id: 2, codigo: '000002', direccion: 'Avenida Principal Mz. A Lt. 02' },
    { id: 3, codigo: '000003', direccion: 'Calle Secundaria Mz. B Lt. 03' },
    { id: 4, codigo: '000004', direccion: 'Pasaje Central Mz. C Lt. 04' },
    { id: 5, codigo: '000005', direccion: 'Jirón Comercial Mz. D Lt. 05' },
    { id: 6, codigo: '000006', direccion: 'Avenida Norte Mz. E Lt. 06' },
    { id: 7, codigo: '000007', direccion: 'Calle Sur Mz. F Lt. 07' },
    { id: 8, codigo: '000008', direccion: 'Pasaje Este Mz. G Lt. 08' },
    { id: 9, codigo: '000009', direccion: 'Avenida Oeste Mz. H Lt. 09' },
    { id: 10, codigo: '000010', direccion: 'Jirón Verde Mz. I Lt. 10' },
    { id: 11, codigo: '000011', direccion: 'Calle Azul Mz. J Lt. 11' },
    { id: 12, codigo: '000012', direccion: 'Avenida Roja Mz. K Lt. 12' },
    { id: 13, codigo: '000013', direccion: 'Pasaje Amarillo Mz. L Lt. 13' },
    { id: 14, codigo: '000014', direccion: 'Jirón Blanco Mz. M Lt. 14' },
    { id: 15, codigo: '000015', direccion: 'Calle Negra Mz. N Lt. 15' },
    { id: 16, codigo: '000016', direccion: 'Avenida Púrpura Mz. O Lt. 16' },
    { id: 17, codigo: '000017', direccion: 'Pasaje Naranja Mz. P Lt. 17' },
    { id: 18, codigo: '000018', direccion: 'Jirón Rosa Mz. Q Lt. 18' },
    { id: 19, codigo: '000019', direccion: 'Calle Marrón Mz. R Lt. 19' },
    { id: 20, codigo: '000020', direccion: 'Avenida Gris Mz. S Lt. 20' },
  ];

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
    predioSearch.addEventListener('input', function() {
      const searchTerm = this.value.toLowerCase();
      if (predioList) {
        predioList.innerHTML = '';
      }

      if (searchTerm.length === 0) {
        if (predioList) {
          predioList.classList.remove('active');
        }
        return;
      }

      const filtered = prediosDatos.filter(p => 
        p.codigo.toLowerCase().includes(searchTerm) ||
        p.direccion.toLowerCase().includes(searchTerm)
      );

      if (filtered.length === 0) {
        if (predioList) {
          predioList.innerHTML = '<div class="arb-dropdown-item">No se encontraron predios</div>';
          predioList.classList.add('active');
        }
        return;
      }

      const display = filtered.slice(0, 5);

      display.forEach(predio => {
        const item = document.createElement('div');
        item.className = 'arb-dropdown-item';
        item.innerHTML = `<strong>${predio.codigo}</strong> - ${predio.direccion}`;
        item.addEventListener('click', function() {
          document.getElementById('predioId').value = predio.id;
          predioSearch.value = `${predio.codigo} - ${predio.direccion}`;
          if (predioList) {
            predioList.classList.remove('active');
          }
        });
        if (predioList) {
          predioList.appendChild(item);
        }
      });

      if (predioList) {
        predioList.classList.add('active');
      }
    });

    document.addEventListener('click', function(event) {
      if (event.target !== predioSearch && event.target !== predioList && predioList) {
        predioList.classList.remove('active');
      }
    });
  }

  if (formAgregarPredio) {
    console.log('[ARBITRIOS] Agregando listener al formulario');
    formAgregarPredio.addEventListener('submit', function(event) {
      event.preventDefault();

      const predioId = document.getElementById('predioId').value;
      if (!predioId) {
        alert('Por favor, selecciona un predio de la lista.');
        return;
      }

      const formData = {
        estado: document.getElementById('estado').value,
        id_contribuyente: document.querySelector('input[name="id_contribuyente"]').value,
        id_predio: predioId,
        id_tipo_registro_origen: document.getElementById('referencia').value,
      };

      console.log('[ARBITRIOS] Formulario enviado:', formData);
      alert('Predio agregado correctamente (demostración)');
      cerrarModal();
    });
  } else {
    console.error('[ARBITRIOS] ERROR: No se encontró formAgregarPredio');
  }

  console.log('[ARBITRIOS] Llamando a setupTableActions()...');
  
  // Pequeño delay para asegurar que el DOM esté completamente renderizado
  setTimeout(function() {
    setupTableActions();
  }, 50);
  
  console.log('[ARBITRIOS] === FIN INICIALIZACIÓN ARBITRIOS ===');
}

function setupTableActions() {
  console.log('[ARBITRIOS] === SETUP TABLE ACTIONS ===');
  
  // Verificar que la tabla existe
  const tabla = document.querySelector('.arb-predios-table');
  console.log('[ARBITRIOS] Tabla encontrada:', tabla ? 'SÍ' : 'NO');
  
  if (!tabla) {
    console.warn('[ARBITRIOS] No hay tabla de predios en la página');
    return;
  }

  // Buscar botones de ver
  let botonesVer = document.querySelectorAll('table.arb-predios-table .btn-ver');
  console.log('[ARBITRIOS] Botones Ver encontrados:', botonesVer.length);
  console.log('[ARBITRIOS] Detalle botones Ver:', Array.from(botonesVer).map(b => ({
    clase: b.className,
    padres: b.closest('tr') ? 'Tiene TR padre' : 'SIN TR padre'
  })));

  // Ver predio
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
    btn.addEventListener('click', function(e) {
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
        if (confirm(`¿Eliminar el predio ${codigo}?`)) {
          console.log('[ARBITRIOS] Eliminando predio:', codigo);
          alert(`Predio ${codigo} eliminado (demostración)`);
          fila.remove();
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
