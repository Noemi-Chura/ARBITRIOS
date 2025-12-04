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

    <div class="arb-table-section">
      <div class="arb-table-wrapper">
        <table class="arb-predios-table">
          <thead>
            <tr>
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
          <tbody>
            <?php if (!empty($predios)): ?>
              <?php foreach ($predios as $predio): ?>
                <tr>
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
                    <button class="btn-ver" title="Ver" data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>"><i class="fas fa-eye"></i></button>
                    <button class="btn-editar" title="Editar" data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>"><i class="fas fa-edit"></i></button>
                    <button class="btn-eliminar" title="Eliminar" data-predio-id="<?= htmlspecialchars($predio['id'] ?? '') ?>"><i class="fas fa-trash"></i></button>
                  </td>
                </tr>
              <?php endforeach; ?>
            <?php else: ?>
              <tr>
                <td colspan="10" class="text-center">No hay predios registrados para este contribuyente.</td>
              </tr>
            <?php endif; ?>
          </tbody>
        </table>
      </div>
    </div>

    <div class="arb-buttons-section">
      <button class="btn-primary" id="btnAgregarPredio">
        <i class="fas fa-plus"></i> Agregar Predio
      </button>
      <button class="btn-secondary">
        <i class="fas fa-download"></i> Importar Predios Desde
      </button>
    </div>
  </div>

</main>

<div id="modalAgregarPredio" class="arb-modal">
  <div class="arb-modal-content arb-modal-horizontal">
    <div class="arb-modal-header">
      <h2>
        <i class="fas fa-home"></i> Crear Registro de Predio
      </h2>
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
            <div id="predioList" class="arb-dropdown-list">
            </div>
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

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>

<!--
  Comentarios de implementación:
  - Vista de Arbitrios con dos cuadros superiores (cabecera + contribuyente).
  - Tabla de predios con scroll horizontal (1/3 de página).
  - Modal para agregar nuevos predios con campos: Estado, Contribuyente (autofill), Predio (busqueda), Referencia.
  - Los datos de predios provienen de la tabla `gen.gen_predio` y `arb.arbitrio`.
  - Las referencias se obtienen de `arb.tipo_registro_origen`.
  - Estados disponibles: Activo, Anulado, Subdividido.
-->

<script>
// Script Arbitrios cargado inline para asegurar disponibilidad
<?php include(__DIR__ . '/../js/arbitrios.js'); ?>
</script>
