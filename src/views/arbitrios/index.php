<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main>
  <div class="arb-fullwidth-wrapper">
    <div class="arb-header">
      <h1 class="arb-title">
        <i class="fas fa-balance-scale arb-title-icon"></i>
        Arbitrios Municipales por Contribuyente
      </h1>
    </div>

    <div class="arb-contrib">
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
                    <button class="btn-ver" title="Ver" data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn-editar" title="Editar" data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>">
                      <i class="fas fa-edit"></i>
                    </button>
                    <!-- En la tabla, cambia el botón eliminar: -->
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
          <button class="btn-crear" id="btnCrearCategorizacion">
            <i class="fas fa-plus-circle"></i> Crear
          </button>
          <button class="btn-clonar" id="btnClonarCategorizacion">
            <i class="fas fa-clone"></i> Clonar
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
          <label for="estado">Estado *</label>
          <select id="estado" name="estado" required>
            <option value="">Seleccionar estado...</option>
            <?php foreach ($estados as $est): ?>
              <option value="<?= htmlspecialchars($est) ?>"><?= htmlspecialchars($est) ?></option>
            <?php endforeach; ?>
          </select>
        </div>
        <div class="arb-form-group">
          <label for="contribuyente">Contribuyente *</label>
          <input type="text" id="contribuyente" name="contribuyente" 
                 value="<?= htmlspecialchars($dato['nombre'] ?? '') ?>" readonly>
          <input type="hidden" name="id_contribuyente" value="<?= htmlspecialchars($dato['id'] ?? '') ?>">
        </div>
        <div class="arb-form-group">
          <label for="predio">Predio / Comercio *</label>
          <div class="arb-select-search">
            <input type="text" id="predioSearch" placeholder="Buscar predio..." class="arb-search-input">
            <div id="predioList" class="arb-dropdown-list"></div>
            <input type="hidden" id="predioId" name="id_predio">
          </div>
        </div>
        <div class="arb-form-group">
          <label for="referencia">Referencia / Origen *</label>
          <select id="referencia" name="id_tipo_registro_origen" required>
            <option value="">Seleccionar referencia...</option>
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
          <button type="submit" class="btn-grabar">Grabar</button>
          <button type="button" class="btn-cancelar" id="btnCancelarModal">Cancelar</button>
        </div>
      </form>
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
              <label>Contribuyente:</label>
              <span id="catContribuyente"></span>
            </div>
            <div class="info-group">
              <label>Dirección del predio:</label>
              <span id="catDireccion"></span>
            </div>
            <div class="info-group">
              <label>Referencia/Origen:</label>
              <span id="catReferencia"></span>
            </div>
          </div>
        </div>
        
        <!-- DATOS BÁSICOS -->
        <div class="categorizacion-basicos">
          <h4><i class="fas fa-info-circle"></i> Datos Básicos</h4>
          <div class="form-row">
            <div class="form-group">
              <label for="catItem">Item *</label>
              <input type="number" id="catItem" name="item" min="1" value="1" required>
              <small>Número correlativo (usar si necesita más de una categoría por predio y año)</small>
            </div>
            <div class="form-group">
              <label for="catAnio">Año *</label>
              <input type="number" id="catAnio" name="anio" min="2020" max="2030" 
                     value="<?= date('Y') ?>" required>
            </div>
          </div>
        </div>
        
        <!-- MESES Y DIMENSIONES -->
        <div class="categorizacion-meses">
          <h4><i class="fas fa-calendar"></i> Meses Afectados y Dimensiones</h4>
          <div class="form-row">
            <div class="form-column">
              <div class="meses-grid">
                <h5>Meses Afectados:</h5>
                <div class="meses-row">
                  <label><input type="checkbox" name="enero"> Enero</label>
                  <label><input type="checkbox" name="febrero"> Febrero</label>
                  <label><input type="checkbox" name="marzo"> Marzo</label>
                  <label><input type="checkbox" name="abril"> Abril</label>
                  <label><input type="checkbox" name="mayo"> Mayo</label>
                  <label><input type="checkbox" name="junio"> Junio</label>
                </div>
                <div class="meses-row">
                  <label><input type="checkbox" name="julio"> Julio</label>
                  <label><input type="checkbox" name="agosto"> Agosto</label>
                  <label><input type="checkbox" name="septiembre"> Septiembre</label>
                  <label><input type="checkbox" name="octubre"> Octubre</label>
                  <label><input type="checkbox" name="noviembre"> Noviembre</label>
                  <label><input type="checkbox" name="diciembre"> Diciembre</label>
                </div>
              </div>
            </div>
            <div class="form-column">
              <div class="dimensiones-grid">
                <h5>Dimensiones del Predio:</h5>
                <div class="dimension-row">
                  <div class="dimension-group">
                    <label for="catFrentera">Frentera en Metros</label>
                    <input type="number" id="catFrentera" name="frentera_metros" step="0.01" min="0" value="0">
                  </div>
                  <div class="dimension-group">
                    <label for="catFrecuencia">Frecuencia de Barrido</label>
                    <input type="number" id="catFrecuencia" name="frecuencia_barrido" min="1" value="1">
                  </div>
                </div>
                <div class="dimension-row">
                  <div class="dimension-group">
                    <label for="catHabitantes">N° Habitantes</label>
                    <input type="number" id="catHabitantes" name="nro_habitantes" min="1" value="1">
                  </div>
                  <div class="dimension-group">
                    <label for="catAreaConstruida">Área Construida (m²)</label>
                    <input type="number" id="catAreaConstruida" name="area_construida" step="0.01" min="0" value="0">
                  </div>
                </div>
                <div class="dimension-row">
                  <div class="dimension-group">
                    <label for="catAreaTerreno">Área de Terreno (m²)</label>
                    <input type="number" id="catAreaTerreno" name="area_terreno" step="0.01" min="0" value="0">
                  </div>
                  <div class="dimension-group">
                    <label for="catDistanciaParque">Distancia a Parque (m)</label>
                    <input type="number" id="catDistanciaParque" name="distancia_a_parque" step="0.01" min="0" value="1000">
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <!-- TRIBUTOS Y CATEGORÍAS - CORREGIDO -->
        <div class="categorizacion-tributos">
          <h4><i class="fas fa-money-check-alt"></i> Tributos, Categorías y Exoneraciones</h4>
          <table class="tributos-table">
            <thead>
              <tr>
                <th>Tributo</th>
                <th>Categoría</th>
                <th>Tipo Exoneración</th>
              </tr>
            </thead>
            <tbody>
              <!-- LIMPIEZA PÚBLICA -->
              <tr>
                <td><strong>Limpieza Pública</strong></td>
                <td>
                  <select name="id_tipo_beneficio_limpieza_publica">
                    <option value="">Seleccionar categoría...</option>
                    <option value="">Sin categoría</option>
                    <option value="">Casa Habitación</option>
                    <option value="">Comercio</option>
                    <option value="">Servicio General</option>
                    <option value="">Entidad Financiera</option>
                    <option value="">Entidad Pública</option>
                    <option value="">Industria</option>
                  </select>
                </td>
                <td>
                  <select name="exoneracion_limpieza_publica">
                    <option value="">Afecto al arbitrio</option>
                    <option value="">Exonerado pensionista a 25%</option>
                    <option value="">Exonerado 33.33%</option>
                    <option value="">Exonerado pensionista a 50%</option>
                    <option value="">Exonerado total 100%</option>
                  </select>
                </td>
              </tr>
              
              <!-- PARQUES Y JARDINES -->
              <tr>
                <td><strong>Parques y Jardines</strong></td>
                <td>
                  <select name="id_tipo_beneficio_parques_jardines">
                    <option value="">Seleccionar categoría...</option>
                    <option value="">Sin categoría</option>
                    <option value="">Frente a áreas verdes</option>
                    <option value="">Cerca de áreas verdes en radio de 1 MZA</option>
                    <option value="">Lejos de áreas verdes más de 1 MZA</option>
                  </select>
                </td>
                <td>
                  <select name="exoneracion_parques_jardines">
                    <option value="">Afecto al arbitrio</option>
                    <option value="">Exonerado pensionista a 25%</option>
                    <option value="">Exonerado 33.33%</option>
                    <option value="">Exonerado pensionista a 50%</option>
                    <option value="">Exonerado total 100%</option>
                  </select>
                </td>
              </tr>
              
              <!-- RESIDUOS SÓLIDOS -->
              <tr>
                <td><strong>Residuos Sólidos</strong></td>
                <td>
                  <select name="id_tipo_beneficio_relleno_sanitario">
                    <option value="">Sin categoría</option>
                  </select>
                </td>
                <td>
                  <select name="exoneracion_relleno_sanitario">
                    <option value="">Afecto al arbitrio</option>
                    <option value="">Exonerado pensionista a 25%</option>
                    <option value="">Exonerado 33.33%</option>
                    <option value="">Exonerado pensionista a 50%</option>
                    <option value="">Exonerado total 100%</option>
                      </option>
                  </select>
                </td>
              </tr>
              
              <!-- SERENAZGO -->
              <tr>
                <td><strong>Serenazgo</strong></td>
                <td>
                  <select name="id_tipo_beneficio_serenazgo">
                    <option value="">Seleccionar categoría...</option>
                    <option value="">Sin categoría</option>
                    <option value="">Terreno sin construir</option>
                    <option value="">Casa Habitación</option>
                    <option value="">Comercio</option>
                    <option value="">Servicio General</option>
                    <option value="">Entidad Financiera</option>
                    <option value="">Industria/Minería</option>
                  </select>
                </td>
                <td>
                  <select name="exoneracion_serenazgo">
                    <option value="">Afecto al arbitrio</option>
                    <option value="">Exonerado pensionista a 25%</option>
                    <option value="">Exonerado 33.33%</option>
                    <option value="">Exonerado pensionista a 50%</option>
                    <option value="">Exonerado total 100%</option>
                  </select>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        
        <div class="categorizacion-buttons">
          <button type="submit" class="btn-grabar">
            <i class="fas fa-save"></i> Guardar
          </button>
          <button type="button" class="btn-cancelar" id="btnCancelarCrearCat">
            Cancelar
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- MODAL PARA CLONAR CATEGORIZACIÓN -->
<div id="modalClonarCategorizacion" class="arb-modal">
  <div class="arb-modal-content">
    <div class="arb-modal-header">
      <h2><i class="fas fa-clone"></i> Clonar Categorización</h2>
      <button class="arb-modal-close" id="btnCerrarClonarCat">&times;</button>
    </div>
    <div class="arb-modal-body">
      <form id="formClonarCategorizacion">
        <div class="form-group">
          <label for="clonarAnio">Nuevo Año *</label>
          <input type="number" id="clonarAnio" name="nuevo_anio" min="2020" max="2030" 
                 value="<?= date('Y') ?>" required>
        </div>
        <div class="form-group">
          <label for="clonarItem">Nuevo Item *</label>
          <input type="number" id="clonarItem" name="nuevo_item" min="1" value="1" required>
        </div>
        <input type="hidden" id="clonarIdDetalle" name="id_arbitrio_detalle">
        <div class="form-buttons">
          <button type="submit" class="btn-grabar">Clonar</button>
          <button type="button" class="btn-cancelar" id="btnCancelarClonarCat">Cancelar</button>
        </div>
      </form>
    </div>
  </div>
</div>

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>
<script type="text/javascript">
<?php 
// Incluir el archivo JS correctamente
$js_path = __DIR__ . '/../js/arbitrios.js';
if (file_exists($js_path)) {
    echo file_get_contents($js_path);
} else {
    echo 'console.error("Archivo JS no encontrado: ' . $js_path . '");';
}
?>
</script>