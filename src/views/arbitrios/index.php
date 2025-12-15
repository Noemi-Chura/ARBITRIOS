<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main class="arbitrios-container">
  <!-- HEADER CON INFO DEL CONTRIBUYENTE -->
  <div class="arb-fullwidth-wrapper">
    <div class="arb-header">
      <h1 class="arb-title">
        <i class="fas fa-balance-scale arb-title-icon"></i>
        Gestión de Arbitrios Municipales
      </h1>
    </div>

    <div class="arb-contrib">
      <!-- INPUT HIDDEN PARA ID CONTRIBUYENTE -->
      <input type="hidden" id="idContribuyente" value="<?= htmlspecialchars($dato['id'] ?? '') ?>">
      
      <div class="arb-row">
        <div class="arb-left">
          <div class="arb-inline">
            <span class="arb-label">Código</span>
            <span class="arb-value"><?= htmlspecialchars($dato['id'] ?? '') ?></span>
          </div>
        </div>

        <div class="arb-right">
          <div class="arb-inline">
            <span class="arb-label">Nombre o Razón social</span>
            <span class="arb-value"><?= htmlspecialchars($dato['nombre'] ?? '') ?></span>
          </div>
        </div>

        <div class="arb-domicilio">
          <div class="arb-inline">
            <span class="arb-label">Domicilio fiscal</span>
            <span class="arb-value"><?= htmlspecialchars($dato['domicilio_fiscal'] ?? '') ?></span>
          </div>
        </div>
      </div>
    </div>

    <!-- TABLA DE PREDIOS CON CHECKBOXES -->
    <div class="arb-table-section">
      <div class="arb-table-wrapper">
        <table class="arb-predios-table">
          <thead>
            <tr>
              <th width="50">
                <input type="checkbox" id="selectAllPredios">
              </th>
              <th>Estado</th>
              <th>Código Predio</th>
              <th>Dirección</th>
              <th>Referencia / Origen</th>
              <th>Usuario</th>
              <th>F. Control</th>
              <th>H. Control</th>
              <th>Estación</th>
              <th>Fecha Servidor</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody id="prediosTableBody">
            <?php if (!empty($predios)): ?>
              <?php foreach ($predios as $predio): ?>
                <tr class="predio-row" data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>">
                  <td>
                    <input type="checkbox" class="predio-checkbox" 
                           data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>">
                  </td>
                  <td><?= htmlspecialchars($predio['estado'] ?? '') ?></td>
                  <td><?= htmlspecialchars($predio['codigo_catastral'] ?? '') ?></td>
                  <td><?= htmlspecialchars($predio['direccion'] ?? '') ?></td>
                  <td><?= htmlspecialchars($predio['referencia_origen'] ?? 'N/A') ?></td>
                  <td><?= htmlspecialchars($predio['usuario_actualizado'] ?? 'Sistema') ?></td>
                  <td><?= htmlspecialchars($predio['f_control'] ?? '') ?></td>
                  <td><?= htmlspecialchars($predio['h_control'] ?? '') ?></td>
                  <td>HPSKULL</td>
                  <td><?= htmlspecialchars($predio['fecha_actualizado'] ?? '') ?></td>
                  <td class="arb-actions">
                    <button class="btn-ver" title="Ver" 
                            data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>"
                            data-contribuyente-id="<?= htmlspecialchars($dato['id'] ?? '') ?>">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-editar" title="Editar" 
                            data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>"
                            data-contribuyente-id="<?= htmlspecialchars($dato['id'] ?? '') ?>"
                            data-id-tipo-registro-origen="<?= htmlspecialchars($predio['id_tipo_registro_origen'] ?? '') ?>"
                            data-estado="<?= htmlspecialchars($predio['estado'] ?? '') ?>">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-eliminar" title="Eliminar" 
                            data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>"
                            data-contribuyente-id="<?= htmlspecialchars($dato['id'] ?? '') ?>">
                        <i class="fas fa-trash"></i>
                    </button>
                  </td>
                </tr>
              <?php endforeach; ?>
            <?php else: ?>
              <tr>
                <td colspan="11" class="text-center">No hay predios registrados para este contribuyente.</td>
              </tr>
            <?php endif; ?>
          </tbody>
        </table>
      </div>
    </div>

    <!-- BOTONES DE ACCIÓN -->
    <div class="arb-buttons-section">
      <button class="btn-primary" id="btnAgregarPredio">
        <i class="fas fa-plus"></i> Agregar Predio
      </button>
      <button class="btn-secondary" id="btnImportarPredios">
        <i class="fas fa-download"></i> Importar Predios Desde
      </button>
    </div>

    <!-- SECCIÓN DE CATEGORIZACIÓN POR AÑOS (se muestra al seleccionar predio) -->
    <div id="categorizacionSection" style="display: none;">
      <div class="arb-subheader">
        <h3><i class="fas fa-calendar-alt"></i> Categorización por Años</h3>
        <div class="arb-subheader-actions">
          <button class="btn-crear" id="btnCrearCategorizacion" title="Crear una nueva categorización para este predio">
            <i class="fas fa-plus-circle"></i> Crear Categorización
          </button>
        </div>
      </div>
      
      <!-- INFO DEL PREDIO SELECCIONADO -->
      <div id="predioInfo" class="arb-predio-info"></div>
      
      <!-- TABLA DE CATEGORIZACIONES -->
      <div class="arb-table-section">
        <div class="arb-table-wrapper">
          <table class="arb-categorizaciones-table">
            <thead>
              <tr>
                <th>Acciones</th>
                <th>Año</th>
                <th>Item</th>
                <th>Ene</th>
                <th>Feb</th>
                <th>Mar</th>
                <th>Abr</th>
                <th>May</th>
                <th>Jun</th>
                <th>Jul</th>
                <th>Ago</th>
                <th>Sep</th>
                <th>Oct</th>
                <th>Nov</th>
                <th>Dic</th>
                <th>Categoría Limpieza</th>
                <th>Categoría Parques</th>
                <th>Categoría Residuos</th>
                <th>Categoría Serenazgo</th>
                <th>Exoneración Limpieza</th>
                <th>Exoneración Parques</th>
                <th>Exoneración Residuos</th>
                <th>Exoneración Serenazgo</th>
                <th>Monto Base</th>
                <th>Interés</th>
                <th>Mora</th>
                <th>Monto Final</th>
                <th>Usuario</th>
                <th>Fecha</th>
              </tr>
            </thead>
            <tbody id="categorizacionesTableBody">
              <!-- Las categorizaciones se cargarán aquí -->
            </tbody>
          </table>
        </div>
      </div>
      
      <!-- BOTONES INFERIORES -->
      <div class="arb-bottom-buttons">
        <button class="btn-ctacte" id="btnActualizarCtacte">
          <i class="fas fa-sync-alt"></i> Actualizar Cuenta Corriente de Predios Marcados
        </button>
        <button class="btn-ctacte" id="btnVerCtacte">
          <i class="fas fa-file-invoice-dollar"></i> Ver Cuenta Corriente de Arbitrios
        </button>
      </div>
    </div>

  </div>

  <!-- TABS Y ESTRUCTURA MEJORADA -->
  <div class="tabs-container" style="margin-top: 20px; margin-left: 20px; margin-right: 20px;">
    <!-- Eliminadas pestañas Predios y Categorías -->
    <button class="tab-button" data-tab="cuenta-corriente" onclick="switchTab('cuenta-corriente')">💰 Estado de Cuenta</button>
    <button class="tab-button" data-tab="recaudacion" onclick="switchTab('recaudacion')">📈 Recaudación</button>
    <button class="tab-button" data-tab="licencias" onclick="switchTab('licencias')">📄 Licencias</button>
    <button class="tab-button" data-tab="pagos" onclick="switchTab('pagos')">💳 Pagos</button>
    <button class="tab-button" data-tab="notificaciones" onclick="switchTab('notificaciones')">📧 Notificaciones</button>
  </div>

  <!-- CONTENEDORES DE TABS -->
  <!-- Eliminados contenedores tab-predios y tab-categorias (la tabla y categorización viven arriba) -->

  <div id="tab-cuenta-corriente" class="tab-content" style="display: none;">
    <h3>Estado de Cuenta Corriente</h3>
    <div id="cuentaCorrienteContent">Cargando...</div>
  </div>

  <div id="tab-recaudacion" class="tab-content" style="display: none;">
    <h3>Reporte de Recaudación</h3>
    <div class="filtros-recaudacion" style="margin-bottom: 15px;">
      <input type="number" id="filtroAnio" placeholder="Año" value="<?= date('Y') ?>" min="2020">
      <input type="number" id="filtroMes" placeholder="Mes (1-12)" min="1" max="12">
      <button onclick="mostrarReporteRecaudacion()" class="btn-small">Filtrar</button>
    </div>
    <div id="recaudacionContent">Cargando...</div>
  </div>

  <div id="tab-licencias" class="tab-content" style="display: none;">
    <h3>Licencias de Funcionamiento</h3>
    <div id="licenciasContent">Cargando...</div>
  </div>

  <div id="tab-pagos" class="tab-content" style="display: none;">
    <h3>Procesar Pagos</h3>
    <div id="pagosContent">Cargando...</div>
  </div>

  <div id="tab-notificaciones" class="tab-content" style="display: none;">
    <h3>Sistema de Notificaciones</h3>
    <button id="btnEnviarNotificacion" class="btn-primary" onclick="notificarContribuyente()">Enviar Notificación de Deuda</button>
    <div id="notificacionesContent" style="margin-top: 15px;"></div>
  </div>

</main>

<!-- MODAL PARA AGREGAR PREDIO -->
<div id="modalAgregarPredio" class="arb-modal">
  <div class="arb-modal-content arb-modal-horizontal">
    <div class="arb-modal-header">
      <h2><i class="fas fa-home"></i> Crear Registro de Predio</h2>
      <button class="arb-modal-close" id="btnCerrarModal">&times;</button>
    </div>
    <div class="arb-modal-body">
      <form id="formAgregarPredio">
        <div class="arb-form-group">
          <label for="estado"><i class="fas fa-info-circle"></i> Estado *</label>
          <select id="estado" name="estado" required class="form-control">
            <option value="">-- Seleccionar estado --</option>
            <option value="activo">Activo</option>
            <option value="subdividido">Subdividido</option>
            <option value="anulado">Anulado</option>
          </select>
        </div>
        <div class="arb-form-group">
          <label for="contribuyente"><i class="fas fa-user"></i> Contribuyente *</label>
          <input type="text" id="contribuyente" name="contribuyente" class="form-control"
                 value="<?= htmlspecialchars($dato['nombre'] ?? '') ?>" readonly>
          <input type="hidden" name="id_contribuyente" value="<?= htmlspecialchars($dato['id'] ?? '') ?>">
        </div>
        <div class="arb-form-group">
          <label for="predio"><i class="fas fa-building"></i> Predio / Comercio *</label>
          <div class="arb-select-search">
            <input type="text" id="predioSearch" placeholder="Buscar predio..." class="arb-search-input form-control">
            <div id="predioList" class="arb-dropdown-list"></div>
            <input type="hidden" id="predioId" name="id_predio">
          </div>
        </div>
        <div class="arb-form-group">
          <label for="referencia"><i class="fas fa-link"></i> Referencia / Origen *</label>
          <select id="referencia" name="id_tipo_registro_origen" required class="form-control">
            <option value="">-- Seleccionar referencia --</option>
            <?php if (!empty($referencias)): ?>
              <?php foreach ($referencias as $ref): ?>
                <option value="<?= htmlspecialchars($ref['id_tipo_registro_origen'] ?? '') ?>">
                  <?= htmlspecialchars($ref['denominacion'] ?? '') ?>
                </option>
              <?php endforeach; ?>
            <?php endif; ?>
          </select>
        </div>
        <div class="arb-form-buttons">
          <button type="submit" class="btn-grabar btn-modern"><i class="fas fa-save"></i> Grabar</button>
          <button type="button" class="btn-cancelar btn-modern" id="btnCancelarModal"><i class="fas fa-times"></i> Cancelar</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL PARA EDITAR PREDIO -->
<div id="modalEditarPredio" class="arb-modal">
  <div class="arb-modal-content arb-modal-horizontal">
    <div class="arb-modal-header">
      <h2><i class="fas fa-edit"></i> Editar Predio</h2>
      <button class="arb-modal-close" id="btnCerrarEditarPredio">&times;</button>
    </div>
    <div class="arb-modal-body">
      <form id="formEditarPredio">
        <input type="hidden" id="editPredioId" name="id_predio">
        <input type="hidden" id="editContribuyenteId" name="id_contribuyente">
        
        <div class="arb-form-group">
          <label for="editEstado"><i class="fas fa-info-circle"></i> Estado *</label>
          <select id="editEstado" name="estado" required class="form-control">
            <option value="">-- Seleccionar estado --</option>
            <option value="activo">Activo</option>
            <option value="subdividido">Subdividido</option>
            <option value="anulado">Anulado</option>
          </select>
        </div>
        
        <div class="arb-form-group">
          <label for="editReferencia"><i class="fas fa-link"></i> Referencia / Origen *</label>
          <select id="editReferencia" name="id_tipo_registro_origen" required class="form-control">
            <option value="">-- Seleccionar referencia --</option>
            <?php if (!empty($referencias)): ?>
              <?php foreach ($referencias as $ref): ?>
                <option value="<?= htmlspecialchars($ref['id_tipo_registro_origen'] ?? '') ?>">
                  <?= htmlspecialchars($ref['denominacion'] ?? '') ?>
                </option>
              <?php endforeach; ?>
            <?php endif; ?>
          </select>
        </div>
        
        <div class="arb-form-buttons">
          <button type="submit" class="btn-grabar btn-modern"><i class="fas fa-save"></i> Actualizar</button>
          <button type="button" class="btn-cancelar btn-modern" id="btnCancelarEditarPredio"><i class="fas fa-times"></i> Cancelar</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL PARA VER PREDIO -->
<div id="modalVerPredio" class="arb-modal">
  <div class="arb-modal-content arb-modal-medium">
    <div class="arb-modal-header">
      <h2><i class="fas fa-eye"></i> Detalle del Predio</h2>
      <button class="arb-modal-close" id="btnCerrarVerPredio">&times;</button>
    </div>
    <div class="arb-modal-body">
      <div id="verPredioContent" style="padding: 15px;">
        <!-- Contenido dinámico -->
      </div>
      <div class="arb-form-buttons">
        <button type="button" class="btn-secondary btn-modern" id="btnCerrarVerPredioBtn"><i class="fas fa-check\"></i> Cerrar</button>
      </div>
    </div>
  </div>
</div>

<!-- En el modal de crear categorización -->
<!-- MODAL PARA CREAR CATEGORIZACIÓN -->
<div id="modalCrearCategorizacion" class="arb-modal">
  <div class="arb-modal-content arb-modal-large">
    <div class="arb-modal-header">
      <h2><i class="fas fa-file-contract"></i> Crear Categorización de Arbitrios</h2>
      <button class="arb-modal-close" id="btnCerrarCrearCat">&times;</button>
    </div>
    <div class="arb-modal-body">
      <form id="formCrearCategorizacion">
        <!-- INFORMACIÓN DEL PREDIO -->
        <div class="categorizacion-info">
          <div class="info-row">
            <div class="info-group">
              <label>📌 Contribuyente:</label>
              <span id="catContribuyente" class="info-value"></span>
            </div>
            <div class="info-group">
              <label>📍 Dirección del predio:</label>
              <span id="catDireccion" class="info-value"></span>
            </div>
            <div class="info-group">
              <label>🔗 Referencia/Origen:</label>
              <span id="catReferencia" class="info-value"></span>
            </div>
          </div>
        </div>
        
        <!-- MESES Y DIMENSIONES - LAYOUT 3 COLUMNAS -->
        <div class="categorizacion-panel-grid">
          <h4 style="grid-column: 1/-1; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #fff; padding: 15px; border-radius: 8px; margin-bottom: 25px;">
            <i class="fas fa-sliders-h"></i> Panel de Configuración: Período, Dimensiones y Métricas
          </h4>
          
          <!-- COLUMNA 1: AÑO E ITEM -->
          <div class="panel-col-1">
            <div class="year-section">
              <label for="catAnio" style="color: #2c3e50; font-weight: 600; font-size: 14px;">
                <i class="fas fa-calendar-alt" style="color: #667eea;"></i> Año del Registro
                <span class="required-mark">*</span>
              </label>
              <input type="number" id="catAnio" name="anio" min="2020" max="2030" 
                     value="<?= date('Y') ?>" required class="year-input">
              <small class="hint-text">Año de vigencia de esta categorización</small>
            </div>
            
            <div class="item-section" style="margin-top: 20px;">
              <label for="catItem" style="color: #2c3e50; font-weight: 600; font-size: 14px;">
                <i class="fas fa-list-ol" style="color: #667eea;"></i> Item
                <span class="required-mark">*</span>
                <span class="help-icon" title="Número correlativo para múltiples categorías">?</span>
              </label>
              <input type="number" id="catItem" name="item" min="1" value="1" required>
              <small class="hint-text">Usar para múltiples categorías en el mismo año</small>
            </div>
          </div>
          
          <!-- COLUMNA 2: MESES (2 sub-columnas) -->
          <div class="panel-col-2">
            <h5><i class="fas fa-calendar-days"></i> Meses Afectados por esta Categorización</h5>
            <div class="meses-grid-2col">
              <div class="meses-col">
                <div class="meses-header">Primer Semestre</div>
                <label class="checkbox-label">
                  <input type="checkbox" name="enero" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Enero</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="febrero" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Febrero</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="marzo" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Marzo</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="abril" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Abril</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="mayo" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Mayo</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="junio" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Junio</span>
                </label>
              </div>
              <div class="meses-col">
                <div class="meses-header">Segundo Semestre</div>
                <label class="checkbox-label">
                  <input type="checkbox" name="julio" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Julio</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="agosto" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Agosto</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="septiembre" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Septiembre</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="octubre" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Octubre</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="noviembre" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Noviembre</span>
                </label>
                <label class="checkbox-label">
                  <input type="checkbox" name="diciembre" class="mes-checkbox">
                  <span class="checkbox-custom"></span>
                  <span>Diciembre</span>
                </label>
              </div>
            </div>
          </div>
          
          <!-- COLUMNA 3: MÉTRICAS -->
          <div class="panel-col-3">
            <h5><i class="fas fa-ruler-combined"></i> Dimensiones y Características del Predio</h5>
            <div class="metrics-grid">
              <!-- Fila A -->
              <div class="metric-item">
                <label for="catFrentera">
                  Frontera (m)
                  <span class="tooltip-info" title="Largo de la fachada en metros">?</span>
                </label>
                <input type="number" id="catFrentera" name="frentera_metros" step="0.01" min="0" value="0" placeholder="0.00">
              </div>
              <div class="metric-item">
                <label for="catHabitantes">
                  Habitantes
                  <span class="tooltip-info" title="Número de personas que viven">?</span>
                </label>
                <input type="number" id="catHabitantes" name="nro_habitantes" min="1" value="1" placeholder="1">
              </div>
              
              <!-- Fila B -->
              <div class="metric-item">
                <label for="catFrecuencia">
                  Frec. Barrido
                  <span class="tooltip-info" title="Veces por semana">?</span>
                </label>
                <input type="number" id="catFrecuencia" name="frecuencia_barrido" min="1" value="1" placeholder="1">
              </div>
              <div class="metric-item">
                <label for="catAreaConstruida">
                  Área Const. (m²)
                  <span class="tooltip-info" title="Metros cuadrados construidos">?</span>
                </label>
                <input type="number" id="catAreaConstruida" name="area_construida" step="0.01" min="0" value="0" placeholder="0.00">
              </div>
              
              <!-- Fila C -->
              <div class="metric-item">
                <label for="catAreaTerreno">
                  Área Terreno (m²)
                  <span class="tooltip-info" title="Total de terreno disponible">?</span>
                </label>
                <input type="number" id="catAreaTerreno" name="area_terreno" step="0.01" min="0" value="0" placeholder="0.00">
              </div>
              <div class="metric-item">
                <label for="catInseguridad">
                  Inseguridad (%)
                  <span class="tooltip-info" title="Porcentaje 0-100">?</span>
                </label>
                <input type="number" id="catInseguridad" name="porcentaje_inseguridad" step="0.01" min="0" max="100" value="0" placeholder="0.00">
              </div>
              
              <!-- Fila D -->
              <div class="metric-item">
                <label for="catLicencia">
                  Licencia Func.
                  <span class="tooltip-info" title="¿Tiene licencia de funcionamiento?">?</span>
                </label>
                <select id="catLicencia" name="tiene_licencia" class="select-styled">
                  <option value="0">No</option>
                  <option value="1">Sí</option>
                </select>
              </div>
              <div class="metric-item">
                <label for="catDistanciaParque">
                  Dist. Parque (m)
                  <span class="tooltip-info" title="Distancia en metros">?</span>
                </label>
                <input type="number" id="catDistanciaParque" name="distancia_a_parque" step="0.01" min="0" value="1000" placeholder="1000">
              </div>
            </div>
          </div>
        </div>
        
        <!-- TRIBUTOS Y CATEGORÍAS - CON MEJOR LAYOUT -->
        <div class="categorizacion-tributos">
          <h4><i class="fas fa-list-check"></i> Configuración de Tributos y Beneficios Tributarios</h4>
          <p class="section-help">Asigne categorías de servicio y tipos de exoneración para cada tributo. Categoría = nivel de servicio; Exoneración = beneficio tributario aplicable.</p>
          <table class="tributos-table tributos-professional">
            <thead>
              <tr>
                <th style="width: 20%; color: #e74c3c;" class="th-tributo">
                  <i class="fas fa-coins"></i> Tributo
                </th>
                <th style="width: 40%; color: #e74c3c;" class="th-categoria">
                  <i class="fas fa-layer-group"></i> Categoría (Nivel de Servicio)
                </th>
                <th style="width: 40%; color: #e74c3c;" class="th-exoneracion">
                  <i class="fas fa-shield-alt"></i> Tipo de Exoneración
                </th>
              </tr>
            </thead>
            <tbody>
              <!-- LIMPIEZA PÚBLICA -->
              <tr class="tributo-row tributo-limpieza">
                <td class="tributo-nombre">
                  <div class="tributo-badge badge-limpieza">
                    <i class="fas fa-broom"></i> Limpieza Pública
                  </div>
                </td>
                <td class="tributo-select select-col-categoria">
                  <select name="id_tipo_beneficio_limpieza_publica" class="select-categoria select-styled" 
                          data-tributo="limpieza_publica" title="Seleccione la categoría de servicio de limpieza">
                    <option value="">-- Seleccionar categoría --</option>
                    <option value="">Sin categoría</option>
                    <?php foreach (($categorias_limpieza ?? []) as $cat): ?>
                      <option value="<?= htmlspecialchars($cat['id_tipo_beneficio'] ?? '') ?>">
                        <?= htmlspecialchars($cat['denominacion'] ?? '') ?>
                      </option>
                    <?php endforeach; ?>
                  </select>
                </td>
                <td class="tributo-select select-col-exoneracion">
                  <select name="exoneracion_limpieza_publica" class="select-exoneracion select-styled" 
                          data-tributo="limpieza_publica" title="Seleccione el tipo de exoneración aplicable">
                    <option value="">Afecto al arbitrio (0% exoneración)</option>
                    <?php foreach (($exoneraciones_limpieza ?? []) as $exo): ?>
                      <option value="<?= htmlspecialchars($exo['id_tipo_beneficio'] ?? '') ?>">
                        <?= htmlspecialchars($exo['denominacion'] ?? '') ?>
                      </option>
                    <?php endforeach; ?>
                  </select>
                </td>
              </tr>
              
              <!-- PARQUES Y JARDINES -->
              <tr class="tributo-row tributo-parques">
                <td class="tributo-nombre">
                  <div class="tributo-badge badge-parques">
                    <i class="fas fa-tree"></i> Parques y Jardines
                  </div>
                </td>
                <td class="tributo-select select-col-categoria">
                  <select name="id_tipo_beneficio_parques_jardines" class="select-categoria select-styled" 
                          data-tributo="parques_jardines" title="Seleccione la categoría de servicio de parques">
                    <option value="">-- Seleccionar categoría --</option>
                    <option value="">Sin categoría</option>
                    <?php foreach (($categorias_parques ?? []) as $cat): ?>
                      <option value="<?= htmlspecialchars($cat['id_tipo_beneficio'] ?? '') ?>">
                        <?= htmlspecialchars($cat['denominacion'] ?? '') ?>
                      </option>
                    <?php endforeach; ?>
                  </select>
                </td>
                <td class="tributo-select select-col-exoneracion">
                  <select name="exoneracion_parques_jardines" class="select-exoneracion select-styled" 
                          data-tributo="parques_jardines" title="Seleccione el tipo de exoneración aplicable">
                    <option value="">Afecto al arbitrio (0% exoneración)</option>
                    <?php foreach (($exoneraciones_parques ?? []) as $exo): ?>
                      <option value="<?= htmlspecialchars($exo['id_tipo_beneficio'] ?? '') ?>">
                        <?= htmlspecialchars($exo['denominacion'] ?? '') ?>
                      </option>
                    <?php endforeach; ?>
                  </select>
                </td>
              </tr>
              
              <!-- RESIDUOS SÓLIDOS -->
              <tr class="tributo-row tributo-residuos">
                <td class="tributo-nombre">
                  <div class="tributo-badge badge-residuos">
                    <i class="fas fa-trash-alt"></i> Residuos Sólidos
                  </div>
                </td>
                <td class="tributo-select select-col-categoria">
                  <select name="id_tipo_beneficio_relleno_sanitario" class="select-categoria select-styled" 
                          data-tributo="residuos_solidos" title="Seleccione la categoría de servicio de residuos">
                    <option value="">-- Seleccionar categoría --</option>
                    <option value="">Sin categoría</option>
                    <?php foreach (($categorias_residuos ?? []) as $cat): ?>
                      <option value="<?= htmlspecialchars($cat['id_tipo_beneficio'] ?? '') ?>">
                        <?= htmlspecialchars($cat['denominacion'] ?? '') ?>
                      </option>
                    <?php endforeach; ?>
                  </select>
                </td>
                <td class="tributo-select select-col-exoneracion">
                  <select name="exoneracion_relleno_sanitario" class="select-exoneracion select-styled" 
                          data-tributo="residuos_solidos" title="Seleccione el tipo de exoneración aplicable">
                    <option value="">Afecto al arbitrio (0% exoneración)</option>
                    <?php foreach (($exoneraciones_residuos ?? []) as $exo): ?>
                      <option value="<?= htmlspecialchars($exo['id_tipo_beneficio'] ?? '') ?>">
                        <?= htmlspecialchars($exo['denominacion'] ?? '') ?>
                      </option>
                    <?php endforeach; ?>
                  </select>
                </td>
              </tr>
              
              <!-- SERENAZGO -->
              <tr class="tributo-row tributo-serenazgo">
                <td class="tributo-nombre">
                  <div class="tributo-badge badge-serenazgo">
                    <i class="fas fa-shield-alt"></i> Serenazgo
                  </div>
                </td>
                <td class="tributo-select select-col-categoria">
                  <select name="id_tipo_beneficio_serenazgo" class="select-categoria select-styled" 
                          data-tributo="serenazgo" title="Seleccione la categoría de servicio de serenazgo">
                    <option value="">-- Seleccionar categoría --</option>
                    <option value="">Sin categoría</option>
                    <?php foreach (($categorias_serenazgo ?? []) as $cat): ?>
                      <option value="<?= htmlspecialchars($cat['id_tipo_beneficio'] ?? '') ?>">
                        <?= htmlspecialchars($cat['denominacion'] ?? '') ?>
                      </option>
                    <?php endforeach; ?>
                  </select>
                </td>
                <td class="tributo-select select-col-exoneracion">
                  <select name="exoneracion_serenazgo" class="select-exoneracion select-styled" 
                          data-tributo="serenazgo" title="Seleccione el tipo de exoneración aplicable">
                    <option value="">-- Seleccionar exoneración --</option>
                    <?php foreach (($exoneraciones_serenazgo ?? []) as $exo): ?>
                      <option value="<?= htmlspecialchars($exo['id_tipo_beneficio'] ?? '') ?>">
                        <?= htmlspecialchars($exo['denominacion'] ?? '') ?>
                      </option>
                    <?php endforeach; ?>
                  </select>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        
        <div class="categorizacion-buttons">
          <button type="submit" class="btn-grabar btn-modern">
            <i class="fas fa-save"></i> Guardar Categorización
          </button>
          <button type="button" class="btn-cancelar btn-modern" id="btnCancelarCrearCat">
            <i class="fas fa-times"></i> Cancelar
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL PARA CLONAR CATEGORIZACIÓN -->
<div id="modalClonarCategorizacion" class="arb-modal">
  <div class="arb-modal-content arb-modal-medium">
    <div class="arb-modal-header">
      <h2><i class="fas fa-clone"></i> Clonar Categorización</h2>
      <button class="arb-modal-close" id="btnCerrarClonarCat">&times;</button>
    </div>
    <div class="arb-modal-body">
      <form id="formClonarCategorizacion">
        <div class="arb-form-group">
          <label for="clonarAnio"><i class="fas fa-calendar"></i> Nuevo Año *</label>
          <input type="number" id="clonarAnio" name="nuevo_anio" min="2020" max="2030" class="form-control"
                 value="<?= date('Y') ?>" required>
        </div>
        <div class="arb-form-group">
          <label for="clonarItem"><i class="fas fa-list-ol"></i> Nuevo Item *</label>
          <input type="number" id="clonarItem" name="nuevo_item" min="1" class="form-control" value="1" required>
        </div>
        <input type="hidden" id="clonarIdDetalle" name="id_arbitrio_detalle">
        <div class="arb-form-buttons">
          <button type="submit" class="btn-grabar btn-modern"><i class="fas fa-clone"></i> Clonar</button>
          <button type="button" class="btn-cancelar btn-modern" id="btnCancelarClonarCat"><i class="fas fa-times"></i> Cancelar</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL PARA EDITAR CATEGORIZACIÓN -->
<div id="modalEditarCategorizacion" class="arb-modal">
  <div class="arb-modal-content arb-modal-large">
    <div class="arb-modal-header">
      <h2><i class="fas fa-pen-to-square"></i> Editar Categorización</h2>
      <button class="arb-modal-close" id="btnCerrarEditarCat">&times;</button>
    </div>
    <div class="arb-modal-body">
      <form id="formEditarCategorizacion">
        <input type="hidden" id="editCatIdDetalle" name="id_arbitrio_detalle">
        <div class="categorizacion-panel-grid">
          <h4 style="grid-column: 1/-1;"><i class="fas fa-sliders-h"></i> Panel de Configuración</h4>
          <div class="panel-col-1">
            <div class="year-section">
              <label for="editCatAnio"><i class="fas fa-calendar-alt"></i> Año <span class="required-mark">*</span></label>
              <input type="number" id="editCatAnio" name="anio" min="2020" max="2035" required>
            </div>
            <div class="item-section" style="margin-top: 20px;">
              <label for="editCatItem"><i class="fas fa-list-ol"></i> Item <span class="required-mark">*</span></label>
              <input type="number" id="editCatItem" name="item" min="1" required>
            </div>
          </div>
          <div class="panel-col-2">
            <h5><i class="fas fa-calendar-days"></i> Meses</h5>
            <div class="meses-grid-2col">
              <div class="meses-col">
                <div class="meses-header">Primer Semestre</div>
                <label class="checkbox-label"><input type="checkbox" name="enero" id="editMesEnero"><span class="checkbox-custom"></span><span>Enero</span></label>
                <label class="checkbox-label"><input type="checkbox" name="febrero" id="editMesFebrero"><span class="checkbox-custom"></span><span>Febrero</span></label>
                <label class="checkbox-label"><input type="checkbox" name="marzo" id="editMesMarzo"><span class="checkbox-custom"></span><span>Marzo</span></label>
                <label class="checkbox-label"><input type="checkbox" name="abril" id="editMesAbril"><span class="checkbox-custom"></span><span>Abril</span></label>
                <label class="checkbox-label"><input type="checkbox" name="mayo" id="editMesMayo"><span class="checkbox-custom"></span><span>Mayo</span></label>
                <label class="checkbox-label"><input type="checkbox" name="junio" id="editMesJunio"><span class="checkbox-custom"></span><span>Junio</span></label>
              </div>
              <div class="meses-col">
                <div class="meses-header">Segundo Semestre</div>
                <label class="checkbox-label"><input type="checkbox" name="julio" id="editMesJulio"><span class="checkbox-custom"></span><span>Julio</span></label>
                <label class="checkbox-label"><input type="checkbox" name="agosto" id="editMesAgosto"><span class="checkbox-custom"></span><span>Agosto</span></label>
                <label class="checkbox-label"><input type="checkbox" name="septiembre" id="editMesSeptiembre"><span class="checkbox-custom"></span><span>Septiembre</span></label>
                <label class="checkbox-label"><input type="checkbox" name="octubre" id="editMesOctubre"><span class="checkbox-custom"></span><span>Octubre</span></label>
                <label class="checkbox-label"><input type="checkbox" name="noviembre" id="editMesNoviembre"><span class="checkbox-custom"></span><span>Noviembre</span></label>
                <label class="checkbox-label"><input type="checkbox" name="diciembre" id="editMesDiciembre"><span class="checkbox-custom"></span><span>Diciembre</span></label>
              </div>
            </div>
          </div>
          <div class="panel-col-3">
            <h5><i class="fas fa-ruler-combined"></i> Dimensiones y Características</h5>
            <div class="metrics-grid">
              <div class="metric-item"><label>Frontera (m)</label><input type="number" step="0.01" id="editCatFrentera" name="frentera_metros"></div>
              <div class="metric-item"><label>Habitantes</label><input type="number" id="editCatHabitantes" name="nro_habitantes"></div>
              <div class="metric-item"><label>Frec. Barrido</label><input type="number" id="editCatFrecuencia" name="frecuencia_barrido"></div>
              <div class="metric-item"><label>Área Const. (m²)</label><input type="number" step="0.01" id="editCatAreaConstruida" name="area_construida"></div>
              <div class="metric-item"><label>Área Terreno (m²)</label><input type="number" step="0.01" id="editCatAreaTerreno" name="area_terreno"></div>
              <div class="metric-item"><label>Licencia</label><select id="editCatLicencia" name="tiene_licencia"><option value="0">No</option><option value="1">Sí</option></select></div>
              <div class="metric-item"><label>% Inseguridad</label><input type="number" step="0.01" id="editCatInseguridad" name="porcentaje_inseguridad"></div>
              <div class="metric-item"><label>Distancia a Parque (m)</label><input type="number" step="0.01" id="editCatDistanciaParque" name="distancia_a_parque"></div>
            </div>
          </div>
        </div>

        <table class="tributos-table" style="margin-top:10px;">
          <thead>
            <tr>
              <th style="color: #e74c3c;">Tributo</th>
              <th style="color: #e74c3c;">Categoría</th>
              <th style="color: #e74c3c;">Exoneración</th>
            </tr>
          </thead>
          <tbody>
            <tr class="tributo-row tributo-limpieza">
              <td class="tributo-nombre">
                <div class="tributo-badge badge-limpieza">
                  <i class="fas fa-broom"></i> Limpieza Pública
                </div>
              </td>
              <td class="tributo-select select-col-categoria">
                <select id="editCatLP" name="id_tipo_beneficio_limpieza_publica" class="select-categoria select-styled" data-tributo="limpieza_publica" title="Seleccione la categoría de limpieza">
                  <option value="">-- Seleccionar categoría --</option>
                  <?php foreach (($categorias_limpieza ?? []) as $c): ?>
                    <option value="<?= htmlspecialchars($c['id_tipo_beneficio'] ?? '') ?>"><?= htmlspecialchars($c['denominacion'] ?? '') ?></option>
                  <?php endforeach; ?>
                </select>
              </td>
              <td class="tributo-select select-col-exoneracion">
                <select id="editExLP" name="exoneracion_limpieza_publica" class="select-exoneracion select-styled" data-tributo="limpieza_publica" title="Seleccione el tipo de exoneración aplicable">
                  <option value="">Afecto (sin exoneración)</option>
                  <?php foreach (($exoneraciones ?? []) as $e): ?>
                    <option value="<?= htmlspecialchars($e['id_tipo_beneficio'] ?? '') ?>"><?= htmlspecialchars($e['denominacion'] ?? '') ?></option>
                  <?php endforeach; ?>
                </select>
              </td>
            </tr>
            
            <tr class="tributo-row tributo-parques">
              <td class="tributo-nombre">
                <div class="tributo-badge badge-parques">
                  <i class="fas fa-tree"></i> Parques y Jardines
                </div>
              </td>
              <td class="tributo-select select-col-categoria">
                <select id="editCatPJ" name="id_tipo_beneficio_parques_jardines" class="select-categoria select-styled" data-tributo="parques_jardines" title="Seleccione la categoría de parques">
                  <option value="">-- Seleccionar categoría --</option>
                  <?php foreach (($categorias_parques ?? []) as $c): ?>
                    <option value="<?= htmlspecialchars($c['id_tipo_beneficio'] ?? '') ?>"><?= htmlspecialchars($c['denominacion'] ?? '') ?></option>
                  <?php endforeach; ?>
                </select>
              </td>
              <td class="tributo-select select-col-exoneracion">
                <select id="editExPJ" name="exoneracion_parques_jardines" class="select-exoneracion select-styled" data-tributo="parques_jardines" title="Seleccione el tipo de exoneración aplicable">
                  <option value="">Afecto (sin exoneración)</option>
                  <?php foreach (($exoneraciones ?? []) as $e): ?>
                    <option value="<?= htmlspecialchars($e['id_tipo_beneficio'] ?? '') ?>"><?= htmlspecialchars($e['denominacion'] ?? '') ?></option>
                  <?php endforeach; ?>
                </select>
              </td>
            </tr>
            
            <tr class="tributo-row tributo-residuos">
              <td class="tributo-nombre">
                <div class="tributo-badge badge-residuos">
                  <i class="fas fa-trash-alt"></i> Residuos Sólidos
                </div>
              </td>
              <td class="tributo-select select-col-categoria">
                <select id="editCatRS" name="id_tipo_beneficio_relleno_sanitario" class="select-categoria select-styled" data-tributo="residuos_solidos" title="Seleccione la categoría de residuos">
                  <option value="">-- Seleccionar categoría --</option>
                  <?php foreach (($categorias_residuos ?? []) as $c): ?>
                    <option value="<?= htmlspecialchars($c['id_tipo_beneficio'] ?? '') ?>"><?= htmlspecialchars($c['denominacion'] ?? '') ?></option>
                  <?php endforeach; ?>
                </select>
              </td>
              <td class="tributo-select select-col-exoneracion">
                <select id="editExRS" name="exoneracion_relleno_sanitario" class="select-exoneracion select-styled" data-tributo="residuos_solidos" title="Seleccione el tipo de exoneración aplicable">
                  <option value="">Afecto (sin exoneración)</option>
                  <?php foreach (($exoneraciones ?? []) as $e): ?>
                    <option value="<?= htmlspecialchars($e['id_tipo_beneficio'] ?? '') ?>"><?= htmlspecialchars($e['denominacion'] ?? '') ?></option>
                  <?php endforeach; ?>
                </select>
              </td>
            </tr>
            
            <tr class="tributo-row tributo-serenazgo">
              <td class="tributo-nombre">
                <div class="tributo-badge badge-serenazgo">
                  <i class="fas fa-shield-alt"></i> Serenazgo
                </div>
              </td>
              <td class="tributo-select select-col-categoria">
                <select id="editCatSE" name="id_tipo_beneficio_serenazgo" class="select-categoria select-styled" data-tributo="serenazgo" title="Seleccione la categoría de serenazgo">
                  <option value="">-- Seleccionar categoría --</option>
                  <?php foreach (($categorias_serenazgo ?? []) as $c): ?>
                    <option value="<?= htmlspecialchars($c['id_tipo_beneficio'] ?? '') ?>"><?= htmlspecialchars($c['denominacion'] ?? '') ?></option>
                  <?php endforeach; ?>
                </select>
              </td>
              <td class="tributo-select select-col-exoneracion">
                <select id="editExSE" name="exoneracion_serenazgo" class="select-exoneracion select-styled" data-tributo="serenazgo" title="Seleccione el tipo de exoneración aplicable">
                  <option value="">Afecto (sin exoneración)</option>
                  <?php foreach (($exoneraciones ?? []) as $e): ?>
                    <option value="<?= htmlspecialchars($e['id_tipo_beneficio'] ?? '') ?>"><?= htmlspecialchars($e['denominacion'] ?? '') ?></option>
                  <?php endforeach; ?>
                </select>
              </td>
            </tr>
          </tbody>
        </table>

        <div class="categorizacion-buttons">
          <button type="submit" class="btn-grabar btn-modern"><i class="fas fa-save"></i> Guardar Cambios</button>
          <button type="button" class="btn-cancelar btn-modern" id="btnCancelarEditarCat"><i class="fas fa-times"></i> Cancelar</button>
        </div>
      </form>
    </div>
  </div>
  
</div>

<!-- MODAL PARA PROCESAR CUENTA CORRIENTE -->
<div id="modalProcesarCtacte" class="arb-modal">
  <div class="arb-modal-content arb-modal-medium">
    <div class="arb-modal-header">
      <h2><i class="fas fa-calculator"></i> Procesar Cuenta Tributaria</h2>
      <button class="arb-modal-close" id="btnCerrarProcesarCtacte">&times;</button>
    </div>
    <div class="arb-modal-body">
      <form id="formProcesarCtacte">
        <div class="arb-form-group">
          <label><i class="fas fa-tag"></i> Tributo:</label>
          <input type="text" value="Arbitrios" readonly class="form-control" style="background-color: #f0f0f0;">
        </div>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
          <div class="arb-form-group">
            <label for="anioDesde"><i class="fas fa-calendar"></i> Desde Año *</label>
            <input type="number" id="anioDesde" name="anio_desde" min="2020" max="2030" class="form-control"
                   value="2023" required>
          </div>
          <div class="arb-form-group">
            <label for="anioHasta"><i class="fas fa-calendar"></i> Hasta Año *</label>
            <input type="number" id="anioHasta" name="anio_hasta" min="2020" max="2030" class="form-control"
                   value="2025" required>
          </div>
        </div>
        
        <div class="arb-form-group" style="margin-top: 15px;">
          <h4><i class="fas fa-check-square"></i> Tributos a procesar:</h4>
          <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-top: 10px;">
            <label class="checkbox-label">
              <input type="checkbox" name="tributos[]" value="1" checked>
              <span class="checkbox-custom"></span>
              <span class="checkbox-text">Limpieza Pública</span>
            </label>
            <label class="checkbox-label">
              <input type="checkbox" name="tributos[]" value="2" checked>
              <span class="checkbox-custom"></span>
              <span class="checkbox-text">Parques y Jardines</span>
            </label>
            <label class="checkbox-label">
              <input type="checkbox" name="tributos[]" value="3" checked>
              <span class="checkbox-custom"></span>
              <span class="checkbox-text">Residuos Sólidos</span>
            </label>
            <label class="checkbox-label">
              <input type="checkbox" name="tributos[]" value="4" checked>
              <span class="checkbox-custom"></span>
              <span class="checkbox-text">Serenazgo</span>
            </label>
          </div>
        </div>
        
        <div class="arb-form-group" style="margin-top: 15px;">
          <label for="fechaVencimiento"><i class="fas fa-calendar-check"></i> Fecha de Vencimiento *</label>
          <input type="date" id="fechaVencimiento" name="fecha_vencimiento" class="form-control"
                 value="<?= date('Y-m-d', strtotime('+30 days')) ?>" required>
        </div>
        
        <div class="arb-form-buttons" style="margin-top: 25px;">
          <button type="submit" class="btn-grabar btn-modern" id="btnProcesarCtacte">
            <i class="fas fa-calculator"></i> Procesar Cuenta Tributaria
          </button>
          <button type="button" class="btn-cancelar btn-modern" id="btnCancelarProcesarCtacte">
            <i class="fas fa-times"></i> Cancelar
          </button>
        </div>
        
        <!-- Resultados del proceso -->
        <div id="resultadoProceso" style="display: none; margin-top: 30px;">
          <h4><i class="fas fa-list-alt"></i> Resultado del Proceso</h4>
          <div class="table-wrapper">
            <table class="result-table" id="tablaResultados">
              <thead>
                <tr>
                  <th>Tributo</th>
                  <th>Predio</th>
                  <th>Código</th>
                  <th>F. Vencimiento</th>
                  <th>Monto Base</th>
                  <th>Interés</th>
                  <th>Mora</th>
                  <th>Total</th>
                  <th>Estado</th>
                </tr>
              </thead>
              <tbody id="cuerpoResultados">
                <!-- Resultados se cargarán aquí -->
              </tbody>
            </table>
          </div>
          <div class="result-totals">
            <div class="total-item">
              <span>Total Procesado:</span>
              <strong id="totalProcesado">S/. 0.00</strong>
            </div>
            <div class="total-item">
              <span>Registros:</span>
              <strong id="totalRegistros">0</strong>
            </div>
          </div>
          <div class="result-actions">
            <button type="button" class="btn-secondary" id="btnExportarResultados">
              <i class="fas fa-file-excel"></i> Exportar a Excel
            </button>
            <button type="button" class="btn-primary" id="btnGenerarRecibos">
              <i class="fas fa-print"></i> Generar Recibos
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL PARA IMPORTAR PREDIOS -->
<div id="modalImportar" class="arb-modal">
  <div class="arb-modal-content arb-modal-medium">
    <div class="arb-modal-header">
      <h2><i class="fas fa-download"></i> Importar Predios</h2>
      <button class="arb-modal-close" id="btnCerrarImportarPredios">&times;</button>
    </div>
    <div class="arb-modal-body">
      <form id="formImportarPredios">
        <div class="arb-form-group">
          <label for="selectImportarDesde"><i class="fas fa-inbox"></i> Importar desde:</label>
          <select id="selectImportarDesde" name="importar_desde" required class="form-control">
            <option value="">-- Seleccione origen --</option>
            <option value="predio">Predio</option>
            <option value="impuesto_predial">Impuesto Predial</option>
            <option value="declaracion_jurada">Declaración Jurada</option>
          </select>
        </div>
        
        <div id="importarResultados" style="margin-top: 20px;">
          <h4 style="margin-top: 0;"><i class="fas fa-list"></i> Predios Disponibles</h4>
          <div class="table-wrapper" style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; border-radius: 4px;">
            <table class="arb-predios-table">
              <thead>
                <tr>
                  <th width="50"><input type="checkbox" id="selectAllPredios"></th>
                  <th>Código</th>
                  <th>Dirección</th>
                  <th>Estado</th>
                </tr>
              </thead>
              <tbody id="prediosDisponiblesBody">
                <!-- Se cargarán los predios disponibles aquí -->
              </tbody>
            </table>
          </div>
          <div class="result-totals" style="margin-top: 15px; padding: 10px; background-color: #f9f9f9; border-radius: 4px;">
            <div class="total-item">
              <span><i class="fas fa-check-circle"></i> Predios seleccionados:</span>
              <strong id="totalSeleccionados">0</strong>
            </div>
          </div>
        </div>
        
        <div class="arb-form-buttons" style="margin-top: 25px;">
          <button type="submit" class="btn-grabar btn-modern" id="btnEjecutarImportar">
            <i class="fas fa-download"></i> Importar Seleccionados
          </button>
          <button type="button" class="btn-secondary btn-modern" id="btnBuscarPredios">
            <i class="fas fa-search"></i> Buscar Predios
          </button>
          <button type="button" class="btn-cancelar btn-modern" id="btnCancelarImportarPredios">
            <i class="fas fa-times"></i> Cancelar
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- ESTILOS PARA TABS -->
<style>
  .tabs-container {
    display: flex;
    gap: 5px;
    border-bottom: 2px solid #eee;
    overflow-x: auto;
  }

  .tab-button {
    padding: 12px 20px;
    background: none;
    border: none;
    border-bottom: 3px solid transparent;
    cursor: pointer;
    font-weight: 500;
    color: #666;
    transition: all 0.3s;
  }

  .tab-button:hover {
    color: #2196F3;
  }

  .tab-button.active {
    color: #2196F3;
    border-bottom-color: #2196F3;
  }

  .tab-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
    margin-top: 15px;
  }

  .filtros-recaudacion {
    display: flex;
    gap: 10px;
  }

  .filtros-recaudacion input {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .btn-small {
    padding: 8px 15px;
    background: #2196F3;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .btn-small:hover {
    background: #1976D2;
  }

  .badge-pagado { background: #4caf50; color: white; padding: 4px 8px; border-radius: 3px; }
  .badge-parcial { background: #ff9800; color: white; padding: 4px 8px; border-radius: 3px; }
  .badge-pendiente { background: #f44336; color: white; padding: 4px 8px; border-radius: 3px; }
</style>

<!-- SCRIPTS -->
<script>
    // Definir BASE_URL para JavaScript
    window.BASE_URL = '<?= BASE_URL ?>';
</script>
<script src="<?= BASE_URL ?>views/js/arbitrios.js"></script>
<script src="<?= BASE_URL ?>views/js/arbitrios_integracion.js"></script>
<?php require_once(__DIR__ . "/../layout/footer.php"); ?>