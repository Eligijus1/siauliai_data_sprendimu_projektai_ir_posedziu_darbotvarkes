<?php
//ini_set('display_errors', 1);
//ini_set('display_startup_errors', 1);
//error_reporting(E_ALL & ~E_NOTICE);

$html = file_get_contents('https://www.siauliai.lt/lt/list/view/posedziu-klausimai2');
$html = str_replace('href="/', 'href="https://www.siauliai.lt/', $html);
$html = str_replace('content="/', 'content="https://www.siauliai.lt/', $html);
$date = date_format(new DateTime(), 'Y-m-d');
$fileName = "$date.html";

file_put_contents("Pages/$fileName", $html);

$dataIndex = [];
$files = scandir('./Pages/', SCANDIR_SORT_ASCENDING);
foreach ($files as $file) {
  if (!is_dir($file)) {
    //echo $file . PHP_EOL;
    $dataIndex[] = $file
  }
}

print_r( $dataIndex);
//file_put_contents("data_index.json", json_encode($dataIndexContentArray));

echo "Done" . PHP_EOL;
