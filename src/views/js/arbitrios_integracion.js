
console.log('[ARBITRIOS_INTEGRACION] Script cargado');

let BASE_URL = (typeof window.BASE_URL !== 'undefined') ? window.BASE_URL : '/';

function initializeArbitriosIntegracion() {
    console.log('✓ Inicializando Arbitrios Integración');
    setupEventListeners();
    setupTabListeners();
    setupPredioSelection();
    
    setTimeout(mostrarPredios, 100);
}

function setupEventListeners() {
    
    const btnNotificar = document.getElementById('btnEnviarNotificacion');
    if (btnNotificar) {
        btnNotificar.addEventListener('click', notificarContribuyente);
    }
}

function setupTabListeners() {
    document.querySelectorAll('.tab-button').forEach(btn => {
        btn.addEventListener('click', function() {
            switchTab(this.getAttribute('data-tab'));
        });
    });
}

function setupPredioSelection() {
    const rows = document.querySelectorAll('.predio-row');
    const checkboxes = document.querySelectorAll('.predio-checkbox');
    rows.forEach(row => {
        row.addEventListener('click', () => {
            const idPredio = row.getAttribute('data-predio-id');
            mostrarCategorizacionPredio(idPredio);
        });
    });
    checkboxes.forEach(cb => {
        cb.addEventListener('change', () => {
            const idPredio = cb.getAttribute('data-predio-id');
            if (cb.checked) {
                mostrarCategorizacionPredio(idPredio);
            }
        });
    });
}

function mostrarCategorizacionPredio(idPredio) {
    if (!idPredio) return;
    
    window.selectedPredioId = idPredio;
    const section = document.getElementById('categorizacionSection');
    const info = document.getElementById('predioInfo');
    if (section) section.style.display = 'block';
    if (info) {
        info.innerHTML = '<div style="padding:8px;background:#f0f7ff;border-left:4px solid #2196F3;border-radius:4px;">Predio seleccionado: ' + idPredio + '</div>';
    }
    
    const activeTab = document.querySelector('.tab-button.active')?.getAttribute('data-tab');
    if (activeTab === 'categorias') {
        mostrarCategorias();
    } else {
        
        if (typeof cargarCategorizacionesPredio === 'function') {
            cargarCategorizacionesPredio(idPredio);
        }
    }
}

function verDetalle(idDetalle) {
    alert('Ver detalle ' + idDetalle + ' (función en desarrollo)');
}

function editarDetalle(idDetalle) {
    if (!idDetalle) return;
    
    alert('Editar detalle ' + idDetalle + ' (función en desarrollo)');
}

function switchTab(tabName) {
    document.querySelectorAll('.tab-content').forEach(tab => tab.style.display = 'none');
    document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));

    const tabContent = document.getElementById('tab-' + tabName);
    if (tabContent) {
        tabContent.style.display = 'block';
        const tabButton = document.querySelector(`[data-tab="${tabName}"]`);
        if (tabButton) tabButton.classList.add('active');
    }

    if (tabName === 'categorias') {
        const section = document.getElementById('categorizacionSection');
        const cont = document.getElementById('categoriasContent');
        if (section && cont && !cont.contains(section)) {
            cont.innerHTML = '';
            cont.appendChild(section);
        }
        if (cont) cont.style.display = 'block';
        if (section) section.style.display = 'block';
        if (window.selectedPredioId) mostrarCategorias();
    }
    if (tabName === 'predios') mostrarPredios();
    if (tabName === 'cuenta-corriente') mostrarCuentaCorriente();
    if (tabName === 'recaudacion') mostrarReporteRecaudacion();
    if (tabName === 'licencias') mostrarLicencias();
    if (tabName === 'pagos') mostrarPagos();
}

function mostrarPredios() {
    const tabPredios = document.getElementById('tab-predios');
    if (!tabPredios) return; 
    if (!tabPredios.innerHTML || tabPredios.innerHTML.trim() === '') {
        
        const fullwidth = document.querySelector('.arb-fullwidth-wrapper');
        if (fullwidth) {
            tabPredios.innerHTML = fullwidth.innerHTML;
        } else {
            tabPredios.innerHTML = '<p style="padding:20px;text-align:center;color:#888;">No se pudo cargar la tabla de predios.</p>';
        }
    }
}

function mostrarCategorias() {
    const cont = document.getElementById('categoriasContent');
    if (!cont) return;

    if (!window.selectedPredioId) {
        cont.innerHTML = '<p style="padding:20px;text-align:center;color:#888;">Seleccione un predio en la pestaña Predios para ver sus categorizaciones.</p>';
        return;
    }

    const section = document.getElementById('categorizacionSection');
    if (!section) {
        cont.innerHTML = '<p style="padding:20px;text-align:center;color:#888;">No se encontró la sección de categorización.</p>';
        return;
    }

    
    if (!cont.contains(section)) {
        cont.innerHTML = '';
        cont.appendChild(section);
    }

    cont.style.display = 'block';
    section.style.display = 'block';

    
    if (typeof cargarCategorizacionesPredio === 'function') {
        console.log('[ARBITRIOS] Cargando categorizaciones para predio:', window.selectedPredioId);
        cargarCategorizacionesPredio(window.selectedPredioId);
    }
}

function mostrarCuentaCorriente() {
    const idContribuyente = document.getElementById('idContribuyente')?.value;
    if (!idContribuyente) {
        document.getElementById('cuentaCorrienteContent').innerHTML = '<p style="color:orange;">No se encontró ID de contribuyente</p>';
        return;
    }

    const url = BASE_URL + 'index.php?c=arbitrios&m=cuentaCorriente&id_contribuyente=' + idContribuyente;
    console.log('Fetch:', url);
    
    fetch(url)
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                if (!data.datos || data.datos.length === 0) {
                    document.getElementById('cuentaCorrienteContent').innerHTML = '<p style="padding:20px;text-align:center;">No hay arbitrios registrados para este contribuyente.</p>';
                    return;
                }
                let html = '<table style="width:100%;border-collapse:collapse;"><thead><tr style="background:#f5f5f5;">';
                html += '<th style="padding:10px;text-align:left;border-bottom:2px solid #ddd;">Año</th>';
                html += '<th style="padding:10px;text-align:left;border-bottom:2px solid #ddd;">Item</th>';
                html += '<th style="padding:10px;text-align:left;border-bottom:2px solid #ddd;">Dirección</th>';
                html += '<th style="padding:10px;text-align:right;border-bottom:2px solid #ddd;">Monto</th>';
                html += '<th style="padding:10px;text-align:right;border-bottom:2px solid #ddd;">Pagado</th>';
                html += '<th style="padding:10px;text-align:right;border-bottom:2px solid #ddd;">Pendiente</th>';
                html += '<th style="padding:10px;text-align:center;border-bottom:2px solid #ddd;">Estado</th></tr></thead><tbody>';

                data.datos.forEach(row => {
                    html += '<tr style="border-bottom:1px solid #eee;">';
                    html += '<td style="padding:8px;">' + row.anio + '</td>';
                    html += '<td style="padding:8px;">' + row.item + '</td>';
                    html += '<td style="padding:8px;">' + (row.direccion || 'N/A') + '</td>';
                    html += '<td style="padding:8px;text-align:right;">S/. ' + parseFloat(row.monto_final || 0).toFixed(2) + '</td>';
                    html += '<td style="padding:8px;text-align:right;">S/. ' + parseFloat(row.monto_pagado || 0).toFixed(2) + '</td>';
                    html += '<td style="padding:8px;text-align:right;"><strong>S/. ' + parseFloat(row.saldo_pendiente || 0).toFixed(2) + '</strong></td>';
                    
                    let badgeClass = 'badge-' + (row.estado_pago || 'pendiente');
                    html += '<td style="padding:8px;text-align:center;"><span style="padding:4px 8px;border-radius:3px;';
                    if (row.estado_pago === 'pagado') html += 'background:#4caf50;color:white;';
                    else if (row.estado_pago === 'parcial') html += 'background:#ff9800;color:white;';
                    else html += 'background:#f44336;color:white;';
                    html += '">' + (row.estado_pago || 'pendiente') + '</span></td></tr>';
                });

                html += '</tbody></table>';
                html += '<div style="background:#fff3cd;padding:15px;margin-top:15px;border-left:4px solid #ffc107;border-radius:4px;">';
                html += '<p><strong>Total Emitido:</strong> S/. ' + parseFloat(data.totales.total_emitido).toFixed(2) + '</p>';
                html += '<p><strong>Total Pagado:</strong> S/. ' + parseFloat(data.totales.total_pagado).toFixed(2) + '</p>';
                html += '<p style="color:#d32f2f;margin:0;"><strong>Total Pendiente:</strong> S/. ' + parseFloat(data.totales.total_pendiente).toFixed(2) + '</p>';
                html += '</div>';

                document.getElementById('cuentaCorrienteContent').innerHTML = html;
            }
        })
        .catch(e => {
            console.error('Error en cuentaCorriente:', e);
            document.getElementById('cuentaCorrienteContent').innerHTML = '<p style="color:red;">Error cargando estado de cuenta</p>';
        });
}

function mostrarReporteRecaudacion() {
    const anio = document.getElementById('filtroAnio')?.value || new Date().getFullYear();
    const mes = document.getElementById('filtroMes')?.value || '';

    let url = BASE_URL + 'index.php?c=arbitrios&m=recaudacion&anio=' + anio;
    if (mes) url += '&mes=' + mes;

    fetch(url)
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                if (!data.datos || data.datos.length === 0) {
                    document.getElementById('recaudacionContent').innerHTML = '<p style="padding:20px;text-align:center;">No hay datos de recaudación para el período seleccionado.</p>';
                    return;
                }
                let html = '<table style="width:100%;border-collapse:collapse;"><thead><tr style="background:#f5f5f5;">';
                html += '<th style="padding:10px;text-align:left;border-bottom:2px solid #ddd;">Tributo</th>';
                html += '<th style="padding:10px;text-align:center;border-bottom:2px solid #ddd;">Mes</th>';
                html += '<th style="padding:10px;text-align:right;border-bottom:2px solid #ddd;">Registros</th>';
                html += '<th style="padding:10px;text-align:right;border-bottom:2px solid #ddd;">Total Base</th>';
                html += '<th style="padding:10px;text-align:right;border-bottom:2px solid #ddd;">Pagado</th>';
                html += '<th style="padding:10px;text-align:right;border-bottom:2px solid #ddd;">Pendiente</th></tr></thead><tbody>';

                data.datos.forEach(row => {
                    html += '<tr style="border-bottom:1px solid #eee;">';
                    html += '<td style="padding:8px;">' + (row.tributo || 'N/A') + '</td>';
                    html += '<td style="padding:8px;text-align:center;">' + (row.mes || '-') + '</td>';
                    html += '<td style="padding:8px;text-align:right;">' + (row.cantidad_registros || 0) + '</td>';
                    html += '<td style="padding:8px;text-align:right;">S/. ' + parseFloat(row.total_base || 0).toFixed(2) + '</td>';
                    html += '<td style="padding:8px;text-align:right;">S/. ' + parseFloat(row.total_pagado || 0).toFixed(2) + '</td>';
                    html += '<td style="padding:8px;text-align:right;">S/. ' + parseFloat(row.total_pendiente || 0).toFixed(2) + '</td></tr>';
                });

                html += '</tbody></table>';
                document.getElementById('recaudacionContent').innerHTML = html;
            }
        })
        .catch(e => console.error('Error:', e));
}

function mostrarLicencias() {
    const idContribuyente = document.getElementById('idContribuyente')?.value;
    if (!idContribuyente) {
        document.getElementById('licenciasContent').innerHTML = '<p style="color:orange;">No se encontró ID de contribuyente</p>';
        return;
    }

    fetch(BASE_URL + 'index.php?c=arbitrios&m=getLicencias&id=' + idContribuyente)
        .then(r => r.json())
        .then(data => {
            if (data.success && data.data && data.data.length > 0) {
                let html = '<table style="width:100%;border-collapse:collapse;"><thead><tr style="background:#f5f5f5;">';
                html += '<th style="padding:10px;text-align:left;border-bottom:2px solid #ddd;">Código Catastral</th>';
                html += '<th style="padding:10px;text-align:left;border-bottom:2px solid #ddd;">Dirección</th>';
                html += '<th style="padding:10px;text-align:center;border-bottom:2px solid #ddd;">Acción</th></tr></thead><tbody>';

                data.data.forEach(predio => {
                    html += '<tr style="border-bottom:1px solid #eee;">';
                    html += '<td style="padding:8px;">' + (predio.codigo || predio.codigo_catastral) + '</td>';
                    html += '<td style="padding:8px;">' + predio.direccion + '</td>';
                    html += '<td style="padding:8px;text-align:center;"><button class="btn-import-licencia" data-id-predio="' + predio.id_predio + '" data-codigo="' + (predio.codigo || predio.codigo_catastral) + '" style="padding:5px 10px;background:#2196F3;color:white;border:none;border-radius:4px;cursor:pointer;">Importar</button></td>';
                    html += '</tr>';
                });

                html += '</tbody></table>';
                document.getElementById('licenciasContent').innerHTML = html;
                
                
                const btnsImport = document.querySelectorAll('.btn-import-licencia');
                btnsImport.forEach(btn => {
                    btn.addEventListener('click', function() {
                        const idPredio = this.getAttribute('data-id-predio');
                        const codigo = this.getAttribute('data-codigo');
                        importarPredioUnico(idPredio, codigo, 'licencias');
                    });
                });
            } else {
                document.getElementById('licenciasContent').innerHTML = '<p>No hay licencias disponibles</p>';
            }
        })
        .catch(e => console.error('Error:', e));
}

function importarPredioUnico(idPredio, codigo, tipoFuente) {
    const idContribuyente = document.getElementById('idContribuyente')?.value;
    if (!idContribuyente) {
        alert('No se encontró ID de contribuyente');
        return;
    }
    
    if (!confirm('¿Importar predio ' + codigo + ' a arbitrios?')) return;
    
    fetch(BASE_URL + 'index.php?c=arbitrios&m=importarPredios', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            id_contribuyente: idContribuyente,
            predios: [{ id_predio: idPredio, codigo: codigo }],
            tipo_fuente: tipoFuente
        })
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            alert('✓ ' + data.message);
            
            window.location.reload();
        } else {
            alert('✗ Error: ' + (data.error || 'Error al importar'));
        }
    })
    .catch(e => {
        console.error('Error:', e);
        alert('✗ Error de conexión');
    });
}

function mostrarPagos() {
    const idContribuyente = document.getElementById('idContribuyente')?.value;
    if (!idContribuyente) {
        document.getElementById('pagosContent').innerHTML = '<p style="color:orange;">No se encontró ID de contribuyente</p>';
        return;
    }

    fetch(BASE_URL + 'index.php?c=arbitrios&m=cuentaCorriente&id_contribuyente=' + idContribuyente)
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                let html = '<div style="background:#f0f7ff;padding:15px;border-radius:4px;border-left:4px solid #2196F3;">';
                html += '<h4 style="margin-top:0;">Arbitrios Pendientes de Pago</h4>';
                html += '<div style="max-height:300px;overflow-y:auto;margin-bottom:15px;">';

                data.datos.forEach(row => {
                    if (row.saldo_pendiente > 0) {
                        html += '<label style="display:flex;align-items:center;gap:8px;margin:8px 0;cursor:pointer;max-width:520px;">';
                        html += '<input type="checkbox" name="detalles" value="' + row.id_arbitrio_detalle + '" data-saldo="' + parseFloat(row.saldo_pendiente).toFixed(2) + '" style="flex:0 0 18px;width:18px;height:18px;">';
                        html += '<span>' + row.anio + ' - Item ' + row.item + ': S/. ' + parseFloat(row.saldo_pendiente).toFixed(2) + '</span>';
                        html += '</label>';
                    }
                });

                html += '</div>';
                html += '<div style="display:flex;justify-content:flex-end;margin:6px 0 14px 0;font-weight:600;">';
                html += 'Total seleccionado: S/. <span id="totalSeleccionadoPagos">0.00</span>';
                html += '</div>';
                html += '<div style="display:grid;grid-template-columns:1fr 1fr auto;gap:10px;align-items:end;">';
                html += '<div><label>Monto a Pagar:</label><br><input type="number" id="montoPago" placeholder="0.00" step="0.01" min="0" style="width:100%;padding:8px;border:1px solid #ddd;box-sizing:border-box;"></div>';
                html += '<div><label>Referencia:</label><br><input type="text" id="refPago" placeholder="Boleta, transferencia..." style="width:100%;padding:8px;border:1px solid #ddd;box-sizing:border-box;"></div>';
                html += '<button id="btnProcesarPago" onclick="procesarPagoFormulario()" disabled style="padding:8px 15px;background:#4caf50;color:white;border:none;border-radius:4px;cursor:pointer;opacity:0.7;">Procesar</button>';
                html += '</div></div>';

                document.getElementById('pagosContent').innerHTML = html;

                
                const cont = document.getElementById('pagosContent');
                const actualizarResumen = () => {
                    const checks = Array.from(cont.querySelectorAll('input[name="detalles"]:checked'));
                    const totalSel = checks.reduce((acc, el) => acc + (parseFloat(el.getAttribute('data-saldo')) || 0), 0);
                    const monto = parseFloat(cont.querySelector('#montoPago')?.value || '0') || 0;
                    const totalSelEl = cont.querySelector('#totalSeleccionadoPagos');
                    if (totalSelEl) totalSelEl.textContent = totalSel.toFixed(2);
                    const btn = cont.querySelector('#btnProcesarPago');
                    if (btn) {
                        const habilitar = checks.length > 0 && monto > 0;
                        btn.disabled = !habilitar;
                        btn.style.opacity = habilitar ? '1' : '0.7';
                        btn.style.cursor = habilitar ? 'pointer' : 'not-allowed';
                    }
                };
                cont.querySelectorAll('input[name="detalles"]').forEach(cb => {
                    cb.addEventListener('change', actualizarResumen);
                });
                const montoInput = cont.querySelector('#montoPago');
                if (montoInput) montoInput.addEventListener('input', actualizarResumen);
                actualizarResumen();
            }
        })
        .catch(e => console.error('Error:', e));
}

function procesarPagoFormulario() {
    const checks = Array.from(document.querySelectorAll('input[name="detalles"]:checked'));
    const detalles = checks.map(el => el.value);
    const montoPago = parseFloat(document.getElementById('montoPago')?.value) || 0;
    const referencia = document.getElementById('refPago')?.value || 'Manual';

    if (!detalles.length) {
        alert('Seleccione al menos un arbitrio');
        return;
    }

    if (montoPago <= 0) {
        alert('Ingrese un monto a pagar válido (> 0)');
        return;
    }

    
    const totalSeleccionado = checks.reduce((acc, el) => acc + (parseFloat(el.getAttribute('data-saldo')) || 0), 0);
    if (totalSeleccionado > 0) {
        const diff = +(montoPago - totalSeleccionado).toFixed(2);
        if (diff < 0) {
            if (!confirm('El monto ingresado es MENOR que el total seleccionado (S/. ' + totalSeleccionado.toFixed(2) + ').\n¿Desea continuar con un pago parcial?')) {
                return;
            }
        } else if (diff > 0) {
            if (!confirm('El monto ingresado es MAYOR que el total seleccionado (S/. ' + totalSeleccionado.toFixed(2) + ').\n¿Desea continuar?')) {
                return;
            }
        }
    }

    fetch(BASE_URL + 'index.php?c=arbitrios&m=procesarPago', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            id_detalles: detalles,
            monto_pagado: montoPago,
            referencia_pago: referencia
        })
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            alert('✓ Pago procesado: ' + data.detalles_actualizados + ' arbitrio(s) actualizado(s)');
            mostrarCuentaCorriente();
        } else {
            alert('✗ Error: ' + data.error);
        }
    })
    .catch(e => console.error('Error:', e));
}

function notificarContribuyente() {
    const idContribuyente = document.getElementById('idContribuyente')?.value;
    if (!idContribuyente) {
        alert('No se encontró ID de contribuyente');
        return;
    }

    if (!confirm('¿Enviar notificación de deuda a este contribuyente?')) return;

    fetch(BASE_URL + 'index.php?c=arbitrios&m=notificar&id_contribuyente=' + idContribuyente)
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                alert('✓ Notificación enviada a: ' + data.email);
                let html = '<div style="background:#e8f5e9;padding:10px;border-radius:4px;border-left:4px solid #4caf50;">';
                html += '<strong>Email:</strong> ' + data.email + '<br>';
                html += '<strong>Monto pendiente:</strong> S/. ' + parseFloat(data.monto_pendiente).toFixed(2);
                html += '</div>';
                document.getElementById('notificacionesContent').innerHTML = html;
            } else {
                alert('✗ Error: ' + data.error);
            }
        })
        .catch(e => console.error('Error:', e));
}

document.addEventListener('DOMContentLoaded', initializeArbitriosIntegracion);
if (document.readyState !== 'loading') {
    initializeArbitriosIntegracion();
}


