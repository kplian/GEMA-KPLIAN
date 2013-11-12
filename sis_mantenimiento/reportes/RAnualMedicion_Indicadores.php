<?php
require_once dirname(__FILE__).'/pxpReport/Report.php';

Class RAnualMedicionIndicadores extends Report {
        
    private $totalNumParos=0;
	private $totalNumParosPl=0;
    private $totalTiempoOpHrs=0.00;
    private $totalTiempoStandByHrs=0.00;
    private $totalTiempoMnpHrs=0.00;
    private $totalTiempoMppHrs=0.00;
    private $dias=0; 
    private $numMeses=0;
    private $mesLiteral='';
    private $anio=0;
    private $maximo=1;
    private $widthCelda;
    private $heightCelda;
    private $puntoOrigenX;
    private $puntoOrigenY;   

    function write($fileName) {
        $pdf = new CustomReport('P', PDF_UNIT, "LETTER", true, 'UTF-8', false);
        $pdf->setDataSource($this->getDataSource());
        // set document information
        $pdf->SetCreator(PDF_CREATOR);
        
        // set default monospaced font
        $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        
        //set margins
        $pdf->SetMargins(PDF_MARGIN_LEFT, 40, PDF_MARGIN_RIGHT);
        $pdf->SetHeaderMargin(10);
        $pdf->SetFooterMargin(PDF_MARGIN_FOOTER);
        
        //set auto page breaks
        $pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);
        
        //set image scale factor
        $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
        
        //set some language-dependent strings
        
        // add a page
        $pdf->AddPage();
        
        $height = 5;
        $width0 = 10;
        $width1 = 15;
        $width2 = 20;
        $width3 = 30;
                
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Localizacion:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3*2, $height, $this->getDataSource()->getParameter('localizacion'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Sistema:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+5, $height, $this->getDataSource()->getParameter('sistema'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Tag:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3, $height, $this->getDataSource()->getParameter('codigo'), 'B', 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->Ln();
                
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1+$width0+4, $height, '', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->SetFillColor(175,238,238, true);
        $pdf->Cell(($width0*4), $height, 'Tiempo en Horas', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width0*2, $height, 'En %', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Ln();      
        $pdf->Cell($width1, $height, 'MES', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,255);
        $pdf->Cell($width0-3, $height, 'PAROS NPL', '1', 0, 'C', true, '', 1, false, 'T', 'C');
		$pdf->Cell($width0-3, $height, 'PAROS PL', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->setTextColor(208,32,144);
        $pdf->Cell($width0, $height, 'OPERATIVO', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->setTextColor(255,215,0);
        $pdf->Cell($width0, $height, 'STAND BY', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->setTextColor(255,0,0);
        $pdf->Cell($width0, $height, 'MNP', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,100,0);
        $pdf->Cell($width0, $height, 'MPP', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width0, $height, 'D', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width0, $height, 'C', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $x=$pdf->getX();
        $y=$pdf->getY();        
        $pdf->Cell(105, $height, 'CALCULO DE INDICADORES', '0', 0, 'C', false, '', 1, false, 'T', 'C');        
        $pdf->Ln();
        
        $this->writeDetalles($this->getDataSource(), $pdf);
        
								$pdf->setXY($x+5,$y+$height*4);
        $pdf->SetFillColor(0,0,255, true);
        $pdf->Cell(45, $height*1, '', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell(5, $height*1, '', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell(45, $height*1, '', '1', 0, 'C', true, '', 1, false, 'T', 'C');
       	
        $pdf->setXY($x+5,$y+$height*10);        
        $pdf->SetFillColor(0,0,255, true);
        $pdf->Cell(45, $height*1, '', '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell(5, $height*1, '', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell(45, $height*1, '', '1', 0, 'C', true, '', 1, false, 'T', 'C');        
        
        $pdf->setXY($x+5,$y+$height);
        //CALCULANDO DATOS
        if($this->dias!==0){        
            $disponibilidad = round((($this->dias*24) - $this->totalTiempoMnpHrs - $this->totalTiempoMppHrs)*100/($this->dias*24),2);
			if($this->totalNumParos==0){
				$tmef = (($this->dias*24)-$this->totalTiempoMnpHrs)/1;            
	            $tmpr = $this->totalTiempoMnpHrs/1;
	            $confiabilidad = round(($tmef*100)/($tmef+$tmpr),2);
			} else{
				$tmef = (($this->dias*24)-$this->totalTiempoMnpHrs)/$this->totalNumParos;            
	            $tmpr = $this->totalTiempoMnpHrs/$this->totalNumParos;
	            $confiabilidad = round(($tmef*100)/($tmef+$tmpr),2);	
			}
            
        }else {
            $disponibilidad = 0;
            $tmef = 0;
            $tmpr = 0;
            $confiabilidad = 0;
        }
        
        $pdf->setXY($x+5,$y+$height*4);
        $pdf->setTextColor(255,255,255);  
        $pdf->Cell(45, $height*1, "Disponibilidad(%) = $disponibilidad", '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell(5, $height*1, '', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell(45, $height*1, "TMEF(Horas) = $tmef", '1', 0, 'C', true, '', 1, false, 'T', 'C');        
        
        $pdf->setXY($x+5,$y+$height*7);
        //CALCULANDO DATOS
        
        $pdf->setXY($x+5,$y+$height*10);
        $pdf->setTextColor(255,255,255);          
        $pdf->Cell(45, $height*1, "Confiabilidad(%) = $confiabilidad", '1', 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell(5, $height*1, '', '0', 0, 'C', false, '', 1, false, 'T', 'C');        
        $pdf->Cell(45, $height*1, "TMPR(Horas) = $tmpr", '1', 0, 'C', true, '', 1, false, 'T', 'C');        
                
        $pdf->Ln();
        
        $pdf->setTextColor(0,0,0);
        $this->dibujarEjeCartesiano($x-90,$y+$height*16+3, $this->maximo, 13,'Comportamiento del Sistema '.$this->getDataSource()->getParameter('codigo'),
                                    'GESTION',$this->anio,'MESES','HORAS',$pdf);
                
        $this->dibujarLineas($this->puntoOrigenX, $this->puntoOrigenY, $this->widthCelda, $this->heightCelda,$this->numMeses, $this->getDataSource(), $pdf);
        
        $this->dibujarCuadroEstaditico($x+30, $y+$height*16+3, $this->numMeses, 'Comportamiento de la Disponibilidad y Confiabilidad',
                                       $this->getDataSource()->getParameter('codigo').' Gestion', $this->anio, 'Meses', 'Porcentaje %', $pdf);
        
        $this->dibujarLineasCuadroEstadistico($this->puntoOrigenX, $this->puntoOrigenY, $this->widthCelda, $this->heightCelda, 12, $this->getDataSource(), $pdf);
         
        $pdf->Output($fileName, 'F');
    }
    
    function writeDetalles (DataSource $dataSource, TCPDF $pdf) {
        $widthMarginLeft = 1;
        $width0 = 10;
        $width1 = 15;
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $height = 5;
        $pdf->SetFillColor(255,255,255, true);
        
        $mes = $dataSource->getParameter('mes');
        $this->anio = $dataSource->getParameter('anio');
        $this->numMeses = $dataSource->getParameter('numMeses');        
        $this->mesLiteral = $dataSource->getParameter('mesLiteral');
        
        $dataset = $dataSource->getDataSet();
		/*echo '<pre>';
		var_dump($dataset);
		echo '</pre>';exit;*/
        
        for ($i=1; $i < 13; $i++) { 
            $pdf->setTextColor(0,0,0);
            $pdf->Cell($width1, $height, $this->nombreMes($i), 1, 0, 'C', false, '', 1, false, 'T', 'C');
            $row=current($dataset);            
            if($row['mes']==$i){
                //calculo de indicadores
                $disponibilidad = (($row['dias']*24) - $row['tiempo_mnp_hrs'] - $row['tiempo_mpp_hrs'])*100/($row['dias']*24);
				if($row['num_paros']==0){
					$tmef = (($row['dias']*24)-$row['tiempo_mnp_hrs']/1);            
	                $tmpr = $row['tiempo_mnp_hrs']/1;
	                $confiabilidad = ($tmef*100)/($tmef+$tmpr);
				} else{
					$tmef = (($row['dias']*24)-$row['tiempo_mnp_hrs']/$row['num_paros']);            
	                $tmpr = $row['tiempo_mnp_hrs']/$row['num_paros'];
	                $confiabilidad = ($tmef*100)/($tmef+$tmpr);	
				}
                
                
                $mayor=max(array($row['num_paros'],$row['tiempo_op_hrs'],$row['tiempo_standby_hrs'],$row['tiempo_mnp_hrs'],$row['tiempo_mpp_hrs']));
                $this->maximo=($this->maximo<$mayor)?$mayor:$this->maximo;
                $pdf->setTextColor(0,0,255);
                $pdf->Cell($width0-3, $height, $row['num_paros'], 1, 0, 'C', false, '', 1, false, 'T', 'C');
				$pdf->Cell($width0-3, $height, $row['num_paros_planif'], 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(208,32,144);
                $pdf->Cell($width0, $height, $row['tiempo_op_hrs'], 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(255,215,0);
                $pdf->Cell($width0, $height, $row['tiempo_standby_hrs'], 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(255,0,0);
                $pdf->Cell($width0, $height, $row['tiempo_mnp_hrs'], 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(0,100,0);
                $pdf->Cell($width0, $height, $row['tiempo_mpp_hrs'], 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(0,0,0);                
                $pdf->Cell($width0, $height, round($disponibilidad,2), 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->Cell($width0, $height, round($confiabilidad,2), 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $this->totalNumParos=$this->totalNumParos+$row['num_paros'];
				$this->totalNumParosPl=$this->totalNumParosPl+$row['num_paros_planif'];
                $this->totalTiempoOpHrs=$this->totalTiempoOpHrs+$row['tiempo_op_hrs'];
                $this->totalTiempoStandByHrs=$this->totalTiempoStandByHrs+$row['tiempo_standby_hrs'];
                $this->totalTiempoMnpHrs=$this->totalTiempoMnpHrs+$row['tiempo_mnp_hrs'];
                $this->totalTiempoMppHrs=$this->totalTiempoMppHrs+$row['tiempo_mpp_hrs'];
                $this->dias=$this->dias+$row['dias'];           
                next($dataset);    
            }else{
                $pdf->setTextColor(0,0,255);
                $pdf->Cell($width0-3, $height, '0', 1, 0, 'C', false, '', 1, false, 'T', 'C');
				$pdf->Cell($width0-3, $height, '0', 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(208,32,144);
                $pdf->Cell($width0, $height, '0.00', 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(255,215,0);
                $pdf->Cell($width0, $height, '0.00', 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(255,0,0);
                $pdf->Cell($width0, $height, '0.00', 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(0,100,0);
                $pdf->Cell($width0, $height, '0.00', 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->setTextColor(0,0,0);                
                $pdf->Cell($width0, $height, '0.00', 1, 0, 'C', false, '', 1, false, 'T', 'C');
                $pdf->Cell($width0, $height, '0.00', 1, 0, 'C', false, '', 1, false, 'T', 'C');                
            }                
            $pdf->Ln();    
        }

        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, "Dias = $this->dias", 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width0*5+24, $height, "", 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Ln();
        $pdf->Cell($width1, $height, $this->dias*24, 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,255);
        $pdf->Cell($width0-3, $height, $this->totalNumParos, 1, 0, 'C', false, '', 1, false, 'T', 'C');
		$pdf->Cell($width0-3, $height, $this->totalNumParosPl, 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(208,32,144);
        $pdf->Cell($width0, $height, $this->totalTiempoOpHrs, 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(255,215,0);
        $pdf->Cell($width0, $height, $this->totalTiempoStandByHrs, 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(255,0,0);
        $pdf->Cell($width0, $height, $this->totalTiempoMnpHrs, 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,100,0);
        $pdf->Cell($width0, $height, $this->totalTiempoMppHrs, 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, "Horas Tot. Año", 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width0-3, $height, "NPL", 1, 0, 'C', false, '', 1, false, 'T', 'C');
		$pdf->Cell($width0-3, $height, "PL", 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width0*2, $height, "Tot.Horas de trabajo gestion", 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width0, $height, "Tot.Hrs.MNP", 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width0, $height, "Tot.Hrs.MPP", 1, 0, 'C', false, '', 1, false, 'T', 'C');        
    }
    
    function dibujarEjeCartesiano($x, $y, $max, $numDias, $titulo, $mes, $anio, $nombreEjeX, $nombreEjeY, TCPDF $pdf){
        $xOrig = $x;
        $yOrig =$y;    
        $width = 105;
        $width1 = 10;
        $height = 5;
        $pdf->setXY($x+10,$y);       
        $pdf->Cell($width, $height, $titulo, '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setXY($x,$y+$height);        
        $y=$pdf->getY()+5;
        $pdf->Cell($width, $height, "$mes $anio", '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $inc = ceil($max/6);
        $numFilas=0;
        $cont=0;        
        while ($max > $cont) {
            $cont = $cont + $inc;
            $numFilas++; 
        }
        $heightCelda = 90/$numFilas;
        //se define el alto de la celda en una unidad para poder graficar las lineas
        $this->heightCelda=$heightCelda/$inc;
        for ($i=$numFilas; $i >= 1; $i--) {                        
            $pdf->setXY($x,$y);    
            $pdf->Cell(5, 1, $i*$inc , '0', 0, 'L', false, '', 1, true, 'T', 'C');         
            $pdf->setXY($x+5,$y);
            $pdf->SetFillColor(175,238,238, true);
            $pdf->Cell($width-5, $heightCelda, '', '1', 0, 'C', true, '', 1, false, 'T', 'C');
            $y=$y+$heightCelda;
        }
        $widthDias=($width-5)/$numDias;
        //se define el ancho de la celda en una unidad para poder graficar las lineas
        $this->widthCelda=$widthDias;
        //punto origen de los ejes
        $this->puntoOrigenX=$x+5;
        $this->puntoOrigenY=$y;
        
        $pdf->setXY($x+3,$y+1);
        for ($i=0; $i <= $numDias; $i++) {             
            $pdf->Cell($widthDias, 1, $i, '0', 0, 'L', false, '', 1, true, 'T', 'C');            
        }
        $black = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0));
        $blue = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 255));
        $magent = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(208,32,144));   
        $gold = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255,215,0));
        $red = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255,0,0));
        $green = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0,100,0));
        //MARCO PARA LAS ETIQUETAS
        $pdf->setXY($x+11,$y+6);
        $pdf->Cell($width-18, $height, '', '1', 0, 'C', false, '', 1, false, 'T', 'C');
        //LAS ETIQUETAS
        $pdf->SetFontSize(5.5);
        $pdf->setXY($x+20,$y+7);                
        $pdf->Line($x+15,$y+8.5,$x+20,$y+8.5,$blue);        
        $pdf->Cell($width1, $height-2, 'Nº PARO', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Line($x+31,$y+8.5,$x+36,$y+8.5,$magent);
        $pdf->setXY($x+20+$width1+6,$y+7);
        $pdf->Cell($width1, $height-2, 'OPERATIVO', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Line($x+47,$y+8.5,$x+52,$y+8.5,$gold);
        $pdf->setXY($x+20+$width1*2+6*2,$y+7);
        $pdf->Cell($width1, $height-2, 'STAND BY', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Line($x+63,$y+8.5,$x+68,$y+8.5,$red);
        $pdf->setXY($x+20+$width1*3+6*3,$y+7);
        $pdf->Cell($width1, $height-2, 'MNP', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Line($x+79,$y+8.5,$x+84,$y+8.5,$green);
        $pdf->setXY($x+20+$width1*4+6*4,$y+7);
        $pdf->Cell($width1, $height-2, 'MPP', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        
        //IMPRIME EJE X
        $pdf->SetFontSize(7.5);
        $pdf->setXY($x,$y+6+$height);
        $pdf->Cell($width, $height, $nombreEjeX, '0', 0, 'C', false, '', 1, false, 'T', 'C');
        
        //MARCO GRANDE
        $pdf->setLineStyle($black);
        $pdf->setXY($xOrig-7,$yOrig);
        $pdf->Cell($width+10, $height*23, '', '1', 0, 'C', false, '', 1, false, 'T', 'C');
        
        //IMPRIME EJE Y
        $pdf->StartTransform();
        $pdf->Rotate(90,$xOrig+25,$yOrig+25);
        $pdf->Text($xOrig-10, $yOrig-5, $nombreEjeY);
        $pdf->StopTransform();
    }

    function dibujarLineas($x, $y,$widthCelda,$heightCelda, $numLineas, DataSource $dataSource, TCPDF $pdf){
        /*$blue = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 255));
        $magent = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(208,32,144));   
        $gold = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255,215,0));
        $red = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255,0,0));
        $green = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0,100,0));
        $xNumParos=$x;
        $yNumParos=$y-0.30;
        $xOperativo=$x;
        $yOperativo=$y-0.15;
        $xStandBy=$x;
        $yStandBy=$y;
        $xMNP=$x;
        $yMNP=$y+0.15;
        $xMPP=$x;
        $yMPP=$y+0.30;
        
        $dataset = $dataSource->getDataSet();
        $yOrigen=$y;
        for ($i=1; $i <= $numLineas; $i++) {
            $row=current($dataset);
            if($row['mes']==$i){
                $pdf->Line($xNumParos,$yNumParos,$xNumParos+$widthCelda,$yOrigen-($heightCelda*$row['num_paros'])-0.3,$blue);
                $pdf->Line($xOperativo,$yOperativo,$xOperativo+$widthCelda,$yOrigen-($heightCelda*$row['tiempo_op_hrs'])-0.15,$magent);
                $pdf->Line($xStandBy,$yStandBy,$xStandBy+$widthCelda,$yOrigen-($heightCelda*$row['tiempo_standby_hrs']),$gold);                
                $pdf->Line($xMNP,$yMNP,$xMNP+$widthCelda,$yOrigen-($heightCelda*$row['tiempo_mnp_hrs'])+0.15,$red);
                $pdf->Line($xMPP,$yMPP,$xMPP+$widthCelda,$yOrigen-($heightCelda*$row['tiempo_mpp_hrs'])+0.3,$green);
                next($dataset);  
                $xNumParos=$xNumParos+$widthCelda;
                $yNumParos=$yNumParos-($heightCelda*$row['num_paros']);                
                $xOperativo=$xOperativo+$widthCelda;
                $yOperativo=$yOperativo-($heightCelda*$row['tiempo_op_hrs']);
                $xStandBy=$xStandBy+$widthCelda;
                $yStandBy=$yStandBy-($heightCelda*$row['tiempo_standby_hrs']);
                $xMNP=$xMNP+$widthCelda;
                $yMNP=$yMNP-($heightCelda*$row['tiempo_mnp_hrs']);
                $xMPP=$xMPP+$widthCelda;
                $yMPP=$yMPP-($heightCelda*$row['tiempo_mpp_hrs']);
            }else{
                $pdf->Line($xNumParos,$yNumParos,$xNumParos+$widthCelda,$yOrigen-0.30,$blue);
                $pdf->Line($xOperativo,$yOperativo,$xOperativo+$widthCelda,$yOrigen-0.15,$magent);
                $pdf->Line($xStandBy,$yStandBy,$xStandBy+$widthCelda,$yOrigen,$gold);
                $pdf->Line($xMNP,$yMNP,$xMNP+$widthCelda,$yOrigen+0.15,$red);
                $pdf->Line($xMPP,$yMPP,$xMPP+$widthCelda,$yOrigen+0.3,$green);                
                $xNumParos=$xNumParos+$widthCelda;
                $yNumParos=$yOrigen-0.3;
                $xOperativo=$xOperativo+$widthCelda;
                $yOperativo=$yOrigen-0.15;
                $xStandBy=$xStandBy+$widthCelda;
                $yStandBy=$yOrigen;
                $xMNP=$xMNP+$widthCelda;
                $yMNP=$yOrigen+0.15;
                $xMPP=$xMPP+$widthCelda;
                $yMPP=$yOrigen+0.3;
            }    
        }*/        
    }

    function nombreMes($mes){
        setlocale(LC_TIME, 'spanish');
        $nombre=ucfirst(strftime("%B",mktime(0, 0, 0, $mes, 1, 2000)));
        return $nombre;
    }
    
    function dibujarCuadroEstaditico($x, $y, $numDias, $titulo, $mes, $anio, $nombreEjeX, $nombreEjeY, TCPDF $pdf){
        //ESTILOS
        $black = array('width' => 0.15, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0));
        $blue = array('width' => 0.15, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 255));
        $magent = array('width' => 0.15, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(208,32,144));   
        $gold = array('width' => 0.15, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255,215,0));
        $red = array('width' => 0.15, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255,0,0));
        $green = array('width' => 0.15, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0,100,0));
            
        $pdf->setLineStyle($black);    
        $xOrig = $x;
        $yOrig =$y;    
        $width = 80;
        $width1 = 10;
        $height = 5;
        $pdf->setXY($x+10,$y);       
        $pdf->Cell($width-20, $height, $titulo, '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setXY($x,$y+$height);        
        $y=$pdf->getY()+5;
        $pdf->Cell($width, $height, "$mes $anio", '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $inc = 10;
        $numFilas=10;
        $cont=0;        
        
        $heightCelda = 90/$numFilas;
        //se define el alto de la celda en una unidad para poder graficar las lineas
        $this->heightCelda=$heightCelda/$inc;
        //se grafican las filas
        for ($i=$numFilas; $i >= 1; $i--) {                        
            $pdf->setXY($x,$y);
            //se grafica el rango en el eje y    
            $pdf->Cell(5, 1, $i*$inc , '0', 0, 'L', false, '', 1, true, 'T', 'C');         
            //se grafica la fila
            $pdf->setXY($x+5,$y);
            $pdf->Cell($width-5, $heightCelda, '', '1', 0, 'C', false, '', 1, false, 'T', 'C');
            $y=$y+$heightCelda;
        }
        $widthDias=($width-5)/$numDias;
        //se define el ancho de la celda en una unidad para poder graficar las lineas
        $this->widthCelda=$widthDias;
        //punto origen de los ejes
        $this->puntoOrigenX=$x+5;
        $this->puntoOrigenY=$y;
        
        //se gran las columnas
        $pdf->setXY($xOrig+5,$yOrig+$height*2);
        for ($i=0; $i < $numDias; $i++) {             
            $pdf->Cell($widthDias, 90, '', '1', 0, 'L', false, '', 1, true, 'T', 'C');            
        }
        
        //se grafica el rango en el eje x
        $pdf->setXY($x+3,$y+1);
        for ($i=0; $i <= $numDias; $i++) {             
            $pdf->Cell($widthDias, 1, $i, '0', 0, 'L', false, '', 1, true, 'T', 'C');            
        }
                
        //IMPRIME EJE X
        $pdf->SetFontSize(7.5);
        $pdf->setXY($x,$y+3);
        $pdf->Cell($width, $height, $nombreEjeX, '0', 0, 'C', false, '', 1, false, 'T', 'C');
        
        //MARCO GRANDE
        $pdf->setLineStyle($black);
        $pdf->setXY($xOrig-7,$yOrig);
        $pdf->Cell($width+10, $height*23, '', '1', 0, 'C', false, '', 1, false, 'T', 'C');
        
        //IMPRIME EJE Y
        $pdf->StartTransform();
        $pdf->Rotate(90,$xOrig+25,$yOrig+25);
        $pdf->Text($xOrig-10, $yOrig-5, $nombreEjeY);
        $pdf->StopTransform();
        
        //LAS ETIQUETAS
        $pdf->SetFontSize(5.5);
        $pdf->setXY($x+20,$y+7);                
        $pdf->Line($x+15,$y+8.5,$x+20,$y+8.5,$blue);        
        $pdf->Cell($width1, $height-2, 'Disponibilidad', '0', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Line($x+47,$y+8.5,$x+52,$y+8.5,$red);
        $pdf->setXY($x+20+$width1*2+6*2,$y+7);
        $pdf->Cell($width1, $height-2, 'Confiabilidad', '0', 0, 'C', false, '', 1, false, 'T', 'C');
    }

    function dibujarLineasCuadroEstadistico($x, $y,$widthCelda,$heightCelda, $numLineas, DataSource $dataSource, TCPDF $pdf){
        /*$blue = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 255));
        $red = array('width' => 0.35, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(255,0,0));
        $xConfiabilidad=$x;
        $yConfiabilidad=$y-0.30;
        $xDisponibilidad=$x;
        $yDisponibilidad=$y-0.15;
        
        $dataset = $dataSource->getDataSet();
        
        $yOrigen=$y;
        for ($i=1; $i <= $numLineas; $i++) {
            $row=current($dataset);            
            if($row['mes']==$i){
                $disponibilidad = (($row['dias']*24) - $row['tiempo_mnp_hrs'] - $row['tiempo_mpp_hrs'])*100/($row['dias']*24);
				if($row['num_paros']==0){
					$tmef = (($row['dias']*24)-$row['tiempo_mnp_hrs']/1);            
	                $tmpr = $row['tiempo_mnp_hrs']/1;
	                $confiabilidad = ($tmef*100)/($tmef+$tmpr);
				} else{
					$tmef = (($row['dias']*24)-$row['tiempo_mnp_hrs']/$row['num_paros']);            
	                $tmpr = $row['tiempo_mnp_hrs']/$row['num_paros'];
	                $confiabilidad = ($tmef*100)/($tmef+$tmpr);	
				}
                
                  
                $pdf->Line($xDisponibilidad,$yDisponibilidad,$xDisponibilidad+$widthCelda,$yOrigen-($heightCelda*$disponibilidad)-0.15,$blue);
                $pdf->Line($xConfiabilidad,$yConfiabilidad,$xConfiabilidad+$widthCelda,$yOrigen-($heightCelda*$confiabilidad)-0.3,$red);
                next($dataset);                
                $xDisponibilidad=$xDisponibilidad+$widthCelda;
                $yDisponibilidad=$yDisponibilidad-($heightCelda*$disponibilidad);                  
                $xConfiabilidad=$xConfiabilidad+$widthCelda;
                $yConfiabilidad=$yConfiabilidad-($heightCelda*$confiabilidad);                                 
            }else{
                
                $pdf->Line($xDisponibilidad,$yDisponibilidad,$xDisponibilidad+$widthCelda,$yOrigen-0.15,$blue);
                $xDisponibilidad=$xDisponibilidad+$widthCelda;
                $yDisponibilidad=$yOrigen-0.15;
                $xConfiabilidad=$xConfiabilidad+$widthCelda;
                $yConfiabilidad=$yOrigen-0.3;                
            }    
        }  */      
    } 
}
?>