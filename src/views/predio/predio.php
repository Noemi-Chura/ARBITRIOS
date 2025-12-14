<?php require_once(__DIR__ . "/../layout/header.php"); ?>

<main>
  <div class="panel">
    <div class="d-flex justify-between align-center mb-20">
      <h1>Lista de Predios</h1>
    </div>

    <div class="table-responsive">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>ID</th>
            <th>ESTADO</th>
            <th>NOMBRE PREDIO</th>
            <th>NUMERO</th>
            <th>LETRA</th>
            <th>MANZANA</th>
            <th>LOTE</th>
            <th>SUBLOTE</th>
            <th>BLOQUE</th>
            <th>EDIFICIO</th>
            <th>PISO</th>
            <th>NRO PARTIDA</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <?php if (!empty($dato)): ?>
            <?php foreach ($dato as $row): ?>
              <tr>
                <td><?= htmlspecialchars($row['id'] ?? '') ?></td>
                <td>
                  <?php 
                  $estado = $row['estado'] ?? '';
                  $badge_class = '';
                  switch($estado) {
                    case 'Activo': $badge_class = 'status-active'; break;
                    case 'Anulado': $badge_class = 'status-cancelled'; break;
                    case 'Subdividido': $badge_class = 'status-subdivided'; break;
                    default: $badge_class = 'status-inactive';
                  }
                  ?>
                  <span class="status-badge <?= $badge_class ?>">
                    <?= htmlspecialchars($estado) ?>
                  </span>
                </td>
                <td><?= htmlspecialchars($row['nombre_predio'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['numero'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['letra'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['manzana'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['lote'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['sublote'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['bloque'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['edificio'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['piso'] ?? '') ?></td>
                <td><?= htmlspecialchars($row['nro_partida'] ?? '') ?></td>
              </tr>
            <?php endforeach; ?>
          <?php else: ?>
            <tr>
              <td colspan="13" class="text-center">
                <div class="alert alert-info">
                  <i class="fas fa-info-circle"></i> No hay predios registrados
                </div>
              </td>
            </tr>
          <?php endif; ?>
        </tbody>
      </table>
    </div>
    
    <?php if (!empty($dato)): ?>
      <div class="d-flex justify-between align-center mt-20">
        <div>
          <span class="text-muted">
            Mostrando <?= count($dato) ?> predios
          </span>
        </div>
      </div>
    <?php endif; ?>
  </div>
</main>

<?php require_once(__DIR__ . "/../layout/footer.php"); ?>