<?php

if (isset($_GET['discussion'])) {

    $totalMessStats = $unControleur->getTotalMessStats($_GET['discussion']);
    $allUsersFromTotalMessStats = array_column($totalMessStats, 'nom');
    $allTotalsFromTotalMessStats = array_column($totalMessStats, 'totalMess');

    $totalMessByMonthByUsers = $unControleur->getTotalMessByMonthByUsersStats($_GET['discussion']);




    $tableau1 = $totalMessByMonthByUsers;

    $months = [];
    $userCharts = [];
    $messageCounts = [];

    foreach ($tableau1 as $tableau2) {
        foreach ($tableau2 as $tableau3) {
            $mois = $tableau3['mois'];
            $prenom = $tableau3['prenom'];
            $nom = $tableau3['nom'];
            $nombre_messages = $tableau3['nombre_total_de_messages'];

            if (!in_array($mois, $months)) {
                $months[] = $mois;
            }

            $userChart = "$prenom $nom";

            if (!in_array($userChart, $userCharts)) {
                $userCharts[] = $userChart;
            }

            if (!isset($messageCounts[$userChart])) {
                $messageCounts[$userChart] = [];
            }

            $messageCounts[$userChart][$mois] = $nombre_messages;
        }
    }

    $chartData = [
        "labels" => $months, // Les mois seront sur l'axe x
        "datasets" => []
    ];

    foreach ($userCharts as $userChart) {
        $userChartMessages = [];
        foreach ($months as $month) {
            $userChartMessages[] = $messageCounts[$userChart][$month] ?? 0;
        }

        $chartData["datasets"][] = [
            "label" => $userChart,
            "data" => $userChartMessages,
        ];
    }
}
?>


<!-- content Statistiques-->
<div id="StatsWrapper" class="w-full hidden flex-col overflow-y-auto h-[calc(100%-50px)] gap-4 divide-y-2 py-4 px-2 items-center">
    <div class="w-[85%]">
        <canvas class="w-full" id="totalMessChart"></canvas>
    </div>
    <div class="w-[85%]">
        <canvas id="messByMonthsChart"></canvas>
    </div>
</div>