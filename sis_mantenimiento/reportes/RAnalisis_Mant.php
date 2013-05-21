<?php
require_once dirname(__FILE__).'/pxpReport/Report.php';

 class CustomReport extends TCPDF {
    
    private $dataSource;
    
    public function setDataSource(DataSource $dataSource) {
        $this->dataSource = $dataSource;
    }
    
    public function getDataSource() {
        return $this->dataSource;
    }
    
    public function Header() {
        $height = 20;
        $x = $this->GetX();
        $y = $this->GetY();
        $this->SetXY($x, $y);
        $this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $this->Image(dirname(__FILE__).'/logo-ypfb-logistica.png', 16, 12, 36);
        
        $x = $this->GetX();
        $y = $this->GetY();
        $this->SetFontSize(14);
        $this->SetFont('','B');        
        $this->Cell(170, $height/2, 'REGISTRO', 1, 2, 'C', false, '', 0, false, 'T', 'C');        
        $this->Cell(170,$height/2, 'PLANILLA DE ANALISIS RCM',1,0,'C',false,'',0,false,'T','C');
        
        $this->setXY($x+170,$y);
        $this->SetFont('','');
        $this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        
        $this->SetFontSize(7);
        
        $width1 = 17;
        $width2 = 23;
        $this->SetXY($x+170, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Codigo:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('codigo'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+170, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Revisión:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '1', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+170, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Fecha Emisión:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '29/06/2012', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+170, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Página:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4,  '                  '.$this->getAliasNumPage().' de '.$this->getAliasNbPages(), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
    }
    
    public function Footer() {
        $this->SetFontSize(5.5);
		$this->setY(-10);
		$ormargins = $this->getOriginalMargins();
		$this->SetTextColor(0, 0, 0);
		//set style for cell border
		$line_width = 0.85 / $this->getScaleFactor();
		$this->SetLineStyle(array('width' => $line_width, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0)));
		$ancho = round(($this->getPageWidth() - $ormargins['left'] - $ormargins['right']) / 3);
		$this->Ln(2);
		$cur_y = $this->GetY();
		//$this->Cell($ancho, 0, 'Generado por XPHS', 'T', 0, 'L');
		$this->Cell($ancho, 0, 'Usuario: '.$_SESSION['_LOGIN'], '', 1, 'L');
		$pagenumtxt = 'Página'.' '.$this->getAliasNumPage().' de '.$this->getAliasNbPages();
		//$this->Cell($ancho, 0, '', '', 0, 'C');
		$fecha_rep = date("d-m-Y H:i:s");
		$this->Cell($ancho, 0, "Fecha impresión: ".$fecha_rep, '', 0, 'L');
		$this->Ln($line_width);
    }
	
	public function MultiRow($pArray,$pWidth,$pAlign) {
		// MultiCell($w, $h, $txt, $border=0, $align='J', $fill=0, $ln=1, $x='', $y='', $reseth=true, $stretch=0)
	
		$page_start = $this->getPage();
		$y_start = $this->GetY();
		$i=0;
		$x=$this->getX();
		$y=$this->getY();
		foreach ($pArray as $value) {
			//$this->MultiCell(40, 0, $value, 1, 'R', 1, 2, '', '', true, 0);
			$nb=max($nb,$this->getNumLines($value,$pWidth[$i]));
			$i++;
			
		}
		
		//ALto de las columnas
		$alto=3*$nb;
		$i=0;
		foreach ($pArray as $value) {
			if($i>0){
				$this->setXY($x,$y);
			}
			$this->MultiCell($pWidth[$i], $alto, $value, 1, $pAlign[$i], 0, 2, '', '', true, 0);
			$i++;
			$x=$this->getX();
		}
		$this->Ln(0);
	}
}

Class RAnalisisMant extends Report {

    function write($fileName) {
        $pdf = new CustomReport('L', PDF_UNIT, "LETTER", true, 'UTF-8', false);
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
        $width1 = 15;
        $width2 = 20;
        $width3 = 40;
        $width4 = 100;
        
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Localizacion:', '', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width4, $height, $this->getDataSource()->getParameter('localizacion'), '', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $x=$pdf->getX();
        $y=$pdf->getY();        
        $pdf->Cell($width3+35, $height*2, '', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setXY($x,$y);
        $pdf->Cell($width1, $height, 'Sistema:', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell(60, $height, $this->getDataSource()->getParameter('nombre_sis'), 'B', 0, 'L', false, '', 1, false, 'T', 'C');        
        $pdf->setXY($x,$y+$height);
        $pdf->setTextColor(0,0,0);   
        $pdf->Cell($width1+5, $height, 'Subsistema:', 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell(55, $height, $this->getDataSource()->getParameter('nombre_sub'), 'T', 0, 'L', false, '', 1, false, 'T', 'C');
        $pdf->setXY($x+$width3+35,$y);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2/2, $height*2, 'TAG:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3, $height*2, $this->getDataSource()->getParameter('tag'), 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $x=$pdf->getX();
        $y=$pdf->getY();        
        $pdf->Cell($width3+$width1+25, $height*2, '', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setXY($x,$y);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1+10, $height, 'Preparado por:', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+15, $height, $this->getDataSource()->getParameter('preparado_por'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->setXY($x,$y+$height);
        $pdf->setTextColor(0,0,0);   
        $pdf->Cell($width1+5, $height, 'Revisado por:', 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+15, $height, $this->getDataSource()->getParameter('revisado_por'), 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setXY($x+$width1+$width3+25,$y);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1+5, $height, 'Fecha:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width2+5, $height, $this->getDataSource()->getParameter('fecha_emision'), 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->setXY($x+$width1+$width3+25,$y+$height);
        $pdf->setTextColor(0,0,0);        
        $pdf->Cell($width1+5, $height, 'Fecha:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width2+5, $height, $this->getDataSource()->getParameter('fecha_rev'), 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        $dataset = $this->getDataSource()->getDataset();
                
        // end title
        
        $colCount = 0;
        $pdf->SetFontSize(6.5);
		//var_dump($dataset);
        foreach($dataset as $row) {
            
            //Tabla
            $widthColVariable = 30;
            $widthColValor = 50;
            $widthSeparator = 15;
            if($colCount == 0) {
                $pdf->Cell(10, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
                $this->writePair($pdf, $row['nombre'], $widthColVariable, $row['valor'], $widthColValor, 0, $height);
                $pdf->Cell($widthSeparator, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
                $colCount++;
            } else {
                $this->writePair($pdf, $row['nombre'], $widthColVariable, $row['valor'], $widthColValor, 0, $height);
                $pdf->Ln(); 
                $colCount = 0;          
            }
        }
        
        $this->writeFuncion($this->getDataSource()->getParameter('funcionDataSource'), $pdf);
        
        $pdf->Output($fileName, 'F');
    }

    function writePair(TCPDF $pdf, $value1, $widthVal1, $value2, $widthVal2, $pairSeparatorWidth, $height) {
        $pdf->SetFont('', '');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($widthVal1, $height, $value1, 0, 0, 'L', false, '', 0, false, 'T', 'C');
        if($pairSeparatorWidth > 0) {
            $pdf->Cell($pairSeparatorWidth, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        }
        
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($widthVal2, $height, $value2, 1, 0, 'C', false, '', 0, false, 'T', 'C');
    }        
    
    function writeFuncion (DataSource $dataSource, TCPDF $pdf) {
        $widthMarginLeft = 1;
        $width = 5;
        
        $pdf->Ln();
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $height = 5;
        $pdf->SetFillColor(51,51,153, true);
        $pdf->setTextColor(255,255,255);
        
        $pdf->Cell($width, $height, '', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($width*10, $height, 'FUNCION', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($width, $height, '', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width*10, $height, 'FALLA FUNCIONAL', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($width, $height, '', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width*14, $height, 'MODOS DE FALLA (Causa de la falla)', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width*13, $height, 'EFECTOS DE FALLA (Que sucede cuando falla)', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->SetFontSize(6.5);
        $x=$pdf->getX();
        $y=$pdf->getY();
		$pdf->SetFont('', '');
        $distance=0;        
		/*echo '<pre>';
		print_r($dataSource);
		echo '</pre>';exit;*/
		//var_dump($dataSource->getDataset());
		
		//PARTE 2
		$aux=0;
		$anchos=array($width,$width*10,$width,$width*10,$width,$width*14,$width*13);
		$aligns=array('C','L','C','L','C','L','L');
		foreach($dataSource->getDataset() as $row) {
			$pdf->MultiRow($row,$anchos,$aligns);
		}
		
		
        /*foreach($dataSource->getDataset() as $row) {
        	if($aux>0){
        		$pdf->setXY($x+15,$aux);	
        	}	
            
            //***$pdf->Cell($width*8, $height*10, $row['descripcion'], 1, 0, 'C', false, '', 0, false, 'T', 'L');
            $pdf->MultiCell($w = $width, $h = $heigth, $txt = $row['fun_orden'], $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			echo $pdf->getY();exit;
			$pdf->MultiCell($w = $width*7, $h = $heigth, $txt = $row['fun_descripcion'], $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			
			$pdf->MultiCell($w = $width, $h = $heigth, $txt = $row['ffall_orden'], $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			$pdf->MultiCell($w = $width*9, $h = $heigth, $txt = $row['ffall_falla'], $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			$pdf->MultiCell($w = $width, $h = $heigth, $txt = $row['mfall_orden'], $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			$pdf->MultiCell($w = $width*10, $h = $heigth, $txt = $row['modo_dalla'], $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			$pdf->MultiCell($w = $width*9, $h = $heigth, $txt = $row['efecto_falla'], $border = 1, $align = 'L', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			if($pdf->getY()>$aux){
				$aux=$pdf->getY();
			}
			
			
			/*$yfalla=$pdf->getY();
			$xfalla=$pdf->getX();*/
			//var_dump($row['dataset']->getDataset());exit;
			//$pdf->setXY($width*11,$yfalla);
			/*foreach ($row['dataset']->getDataset() as $falla) {
				$pdf->MultiCell($w = $width*10, $h = $heigth, $txt = $falla['desc_falla_evento'], $border = 1, $align = 'L', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
				$pdf->setXY($width*11,$pdf->getY());
				$y2=$pdf->getY();
				$x2=$pdf->getX();
				$pdf->setXY($x2,$y2);
				foreach ($falla['dataset']->getDataset() as $modo) {
					$pdf->MultiCell($w = $width*10, $h = $heigth, $txt = $falla['modo_falla'], $border = 1, $align = 'L', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
					$pdf->MultiCell($w = $width*10, $h = $heigth, $txt = $falla['efecto_falla'], $border = 1, $align = 'L', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
				}
			}*/
			//$pdf->setXY($xfalla,$yfalla);
			
			
            
            //$xfalla=$pdf->getX();
            //$yfalla=$pdf->getY();            
            /*$numFallas=count($row['dataset']->getDataset());
            if($numFallas!==0)
                $intervaloFallas=50/$numFallas;
            $distanciaFalla=0;*/
			
			//PARTE 3                                  
            /*foreach ($row['dataset']->getDataset() as $falla) {
                
                $pdf->setXY($xfalla,$yfalla+$intervaloFallas*$distanciaFalla);
                $pdf->Cell($width*10, $intervaloFallas, $falla['modo_falla'], 1, 0, 'C', false, '', 0, false, 'T', 'L');                    
                
                $xModo=$pdf->getX();
                $yModo=$pdf->getY();
                $numModos=count($falla['dataset']->getDataset());
                if($numModos!==0)
                    $intervaloModo=$intervaloFallas/$numModos;
                $distanceModo=0;
                foreach ($falla['dataset']->getDataset() as $modo) {
                    $pdf->setXY($xModo,$yModo+$intervaloModo*$distanceModo);
                    $pdf->Cell($width*10, $intervaloModo, $modo['modo_falla'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
                    $pdf->Cell($width*9, $intervaloModo, $modo['efecto_falla'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
                    $distanceModo++;
                    //$pdf->Ln();
                }
                $distanciaFalla++;                 
            }*/
            $distance++;
       // }*/
    }    
}
?>