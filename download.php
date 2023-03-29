<?php
//ini_set('display_errors', 1);
//ini_set('display_startup_errors', 1);
//error_reporting(E_ALL & ~E_NOTICE);

$html = file_get_contents('https://www.siauliai.lt/lt/list/view/posedziu-klausimai2');

$html = str_replace('href="/', 'href="/Pages/resources/', $html);
$html = str_replace('content="/', 'content="/Pages/resources/', $html);
$html = str_replace('src="/', 'src="/Pages/resources/', $html);

$date = date_format(new DateTime(), 'Y-m-d');
$fileName = "$date.html";
$dataIndex = [];

file_put_contents("Pages/$fileName", $html);

$files = scandir('./Pages/', SCANDIR_SORT_ASCENDING);
foreach ($files as $file) {
  if (!is_dir($file)) {
    $dataIndex[] = $file;
  }
}

//print_r($dataIndex);
file_put_contents("data_index.json", json_encode($dataIndex));

echo "Done" . PHP_EOL;
