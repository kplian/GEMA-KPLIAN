<?php
$todo='';
$ruta=dirname(__FILE__).'/issues2.json';
$ruta1=dirname(__FILE__).'/result.csv';
//echo $ruta;exit;
$file=fopen($ruta,'r');
$arch=fopen($ruta1,'w+');
//echo 'Archivo: '.$file;exit;
$i=0;
while(!feof($file)||$sw){
	//echo 'asdasd';exit;
	$line=fgets($file);
	$todo=$todo.$line;
//	echo '<br>'.$line;
	if($i>10){
		$sw=0;
	}
	$i++;
}

$issues=json_decode($todo);

//echo count($issues);
//var_dump($aux);
/*echo '<pre>';
print_r($issues);
echo '</pre>';*/

/*for($i=0; $i<sizeof($aux); $i++){
	$tmp = $results[$i];
	echo $tmp;
}*/
	
//echo $issues[0]['stdClass'];

//echo '<pre>';


$sustituye = array("(\r\n)", "(\n\r)", "(\n)", "(\r)");

$marca='@@@@';
foreach ($issues as $indice => $valor) {
	$labels='';
	$milestone='';
	unset($var);
	//etiquetas
	foreach ($valor->labels as $subind => $subval) {
		$labels=$labels.$subval->name.',';
	}
	if($labels==''){
		$labels='sin etiquetas';
	}
	$desc='Descripción: '.$valor->body;
	$desc= preg_replace($sustituye, "$", $desc);

	echo 'Número issue: '.$valor->number.'<br>';
	echo 'Título: '.$valor->title.'<br>';
	echo $desc.'<br>';
	echo 'dev: '.$valor->assignee->login.'<br>';
	echo 'id_dev: '.$valor->assignee->id.'<br>';
	echo 'labels:'.$labels.'<br>';
	echo 'cerrado en: '.$valor->closed_at.'<br>';
	echo 'modificado: '.$valor->updated_at.'<br>';
	echo 'milestone:'.$valor->milestone->title.'<br>';
	echo 'estado: '.$valor->state.'<br>';
	echo 'creador: '.$valor->user->login.'<br>';    
	echo 'id_creador: '.$valor->user->id.'<br>';
	echo '*****************************<br>';
	
	$var[0]="'".$valor->number."'";
	$var[1]="'".$valor->title."'";
	$var[2]="'".$valor->body."'";
	$var[3]="'".$valor->assignee->login."'";
	$var[4]="'".$valor->assignee->id."'";
	$var[5]="'".$labels."'";
	$var[6]="'".$valor->closed_at."'";
	$var[7]="'".$valor->updated_at."'";
	$var[8]="'".$valor->milestone->title."'";
	$var[9]="'".$valor->state."'";
	$var[10]="'".$valor->user->login."'";
	$var[11]="'".$valor->user->id."'";
	
	$cad='';
	foreach ($var as $key) {
		$cad=$cad.$key.$marca;	
	}
	//$cad = eregi_replace('[\n|\r|\n\r]', ' ', $cad);
	$cad=$cad.'\r\n';
	echo '<br>#############'.$cad.'######################<br>';
	fwrite($arch,$cad);
		

}
fclose($arch);
//echo '</pre>';
//echo 'fuck';
var_dump($var);

/*for($i=0;$i<count($aux);$i++){
	echo $aux[$i];
	if($aux[$i]=='number'){
		echo 'Number:'.$aux[$i].'<br>';
	}
	for($j;$j<count($aux[$j]);$j++){
		
	}
}*/
	

	
?>