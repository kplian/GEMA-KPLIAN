<?php
//require_once dirname(__FILE__).'/../../lib/tcpdf_5_9_196/config/lang/eng.php';
//require_once(dirname(__FILE__).'/../../lib/tcpdf_5_9_196/tcpdf.php');
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
		
		$this->SetFontSize(14);
		$this->SetFont('','B');
		
		$this->Cell(105, $height/2, 'REGISTRO', 1, 2, 'C', false, '', 0, false, 'T', 'C');        
        $this->Cell(105,$height/2, 'Ficha Técnica',1,0,'C',false,'',0,false,'T','C');
        
        $this->setXY($x+145,$y);
        $this->SetFont('','');
        $this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        
        $this->SetFontSize(7);
        
        $width1 = 17;
        $width2 = 23;
        $this->SetXY($x+145, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Código:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, 'GMAN-RG-SM-006', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+145, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Revisión:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '1.0', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+145, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Fecha Emision:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '26/05/2012', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+145, $y);
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
	
	public function MultiRow($pMatriz,$pWidth,$pAlign,$pVisible=array(),$pConNumeracion=1) {
		// MultiCell($w, $h, $txt, $border=0, $align='J', $fill=0, $ln=1, $x='', $y='', $reseth=true, $stretch=0)
		$page_start = $this->getPage();
		$y_start = $this->GetY();
		
		//Obtiene el total de filas 
		$totalFilas=count($pMatriz)-1;
		$fila=0;
		
		foreach ($pMatriz as $row) {
			//Obtiene el alto máximo de la celda de toda la fila
			$i=0;
			$nb=0;
			
			$x=$this->getX();
			$y=$this->getY();
			//var_dump($this->array_unshift_assoc($fila,'nro',$fila));exit;
			foreach ($row as $value) {
				$nb=max($nb,$this->getNumLines($value,$pWidth[$i]));
				$i++;
			}
			//Define el alto máximo
			$alto=3*$nb;
			$j=0;
			$tmp=$fila+1;
			if($pConNumeracion){
				$row=$this->array_unshift_assoc($row,'nro',$tmp);	
			}
			
			//Dibuja la fila
			foreach ($row as $value) {
				if($i>0){
					$this->setXY($x,$y);
				}
				
				//Verificación de borde
				if($fila==$totalFilas){
					if($value==''){
						$borde='LRB';
					} else{
						$borde='LRTB';
					}
				} else{
					if($value==''){
						$borde='LR';
					} else{
						$borde='LRT';
					}
				}
				// MultiCell($w, $h, $txt, $border=0, $align='J', $fill=0, $ln=1, $x='', $y='', $reseth=true, $stretch=0)
				$this->MultiCell($pWidth[$j], $alto, $value, $borde, $pAlign[$j], 0, 0, '', '', true, 0);
				$j++;
				$x=$this->getX();
				//$this->Ln();	
			}
			$this->Ln();
			$fila++;
		}
	}

	public function array_unshift_assoc(&$arr, $key, $val){
	    $arr = array_reverse($arr, true);
	    $arr[$key] = $val;
	    return array_reverse($arr, true);
	}
}

Class RUniCons_FichaTecnica extends Report {

	function write($fileName) {
		$pdf = new CustomReport(PDF_PAGE_ORIENTATION, PDF_UNIT, "LETTER", true, 'UTF-8', false);
		$pdf->setDataSource($this->getDataSource());
		// set document information
		$pdf->SetCreator(PDF_CREATOR);
		/*$pdf->SetAuthor('Nicola Asuni');
		$pdf->SetTitle('TCPDF Example 006');
		$pdf->SetSubject('TCPDF Tutorial');
		$pdf->SetKeywords('TCPDF, PDF, example, test, guide');
		*/
		
		// set default monospaced font
		$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
		
		//set margins
		$pdf->SetMargins(PDF_MARGIN_LEFT, 32, PDF_MARGIN_RIGHT);
		$pdf->SetHeaderMargin(10);
		$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);
		
		//set auto page breaks
		$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);
		
		//set image scale factor
		$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
		
		//set some language-dependent strings
		// $pdf->setLanguageArray($l);
		
		// add a page
		$pdf->AddPage();
		
		$height = 4;
		$width1 = 30;
		$width2 = 90;
		$pdf->SetFontSize(8);
		$pdf->SetFont('', 'B');
		$pdf->Cell(0, $height, 'INFORMACIÓN:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Ln();
		
		$pdf->SetFontSize(6.5);
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Propietario:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, 'YPFB LOGÍSTICA SA.', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
		$xPictureBox = $pdf->GetX();
		$yPictureBox = $pdf->GetY();
		/*$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Area:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, '**', 'B', 0, 'L', false, '', 0, false, 'T', 'C');*/
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Nombre:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, $this->getDataSource()->getParameter('nombre'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Localización:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, $this->getDataSource()->getParameter('localizacion'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Punto:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, $this->getDataSource()->getParameter('punto'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $width1, $h = $height, $txt = 'Función:', $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		//$pdf->Cell($w = $width2, $h = $height,   $txt = $this->getDataSource()->getParameter('funcion'), $border = 'B', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->MultiCell($w = $width2, $h = $height*2, $txt = $this->getDataSource()->getParameter('funcion'), $border = 'B', $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'B', $fitcell = false);
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $width1, $h = $height, $txt = 'No. Pto. Despacho:', $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($w = $width2, $h = $height, $txt = $this->getDataSource()->getParameter('puntoRecepcionDespacho'), $border = 'B', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		$pdf->Ln();
		
		$xContinue = $pdf->GetX();
		$yContinue = $pdf->GetY();
		
		//write immage
		$pdf->SetXY($xPictureBox, $yPictureBox);
		if($this->getDataSource()->getParameter('imagePath') != null) {
			$pdf->Image($file = $this->getDataSource()->getParameter('imagePath'), $x = $xPictureBox, $y = $yPictureBox, 
				$w = 65, $h = 35, $type = '', $link = '', $align = '', $resize = true, $dpi = 300, $palign = '', $ismask = false, $imgmask = false, $border = 1, $fitbox = false, $hidden = false, $fitonpage = false, $alt = false, $altimgs = array()); 	
		} else {
			$pdf->SetXY($xPictureBox, $yPictureBox);
			$pdf->Cell(65, 35, '', 1, 0, 'L', false, '', 0, false, 'T', 'C');
		}
		
		//paint el detalle del padre
		$dataset = $this->getDataSource()->getDataset();
		$pdf->SetXY($xContinue, $yContinue);
		//Detalle de la unidad constructiva
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell(185, $height, 'IDENTIFICACIÓN', 0, 0, 'C', true, '', 0, true, 'T', 'C');
		$pdf->Ln();
		$height=3;
		// end title
		
		$colCount = 0;
		$pdf->SetFontSize(6.5);
		
		
		$widthColVariable = 30;
		$widthColValor = 50;
		$widthSeparator = 15;
		
		$pdf->Cell(10, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		$this->writePair($pdf, 'TAG', $widthColVariable, $this->getDataSource()->getParameter('codigo'), $widthColValor, 0, $height);
		$pdf->Cell($widthSeparator, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		$colCount++;
		
		foreach($dataset as $row) {
			
			//Tabla
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
		
		//$this->writeRepuestos($this->getDataSource()->getParameter('repuestoDataSource'), $pdf);
		//$pdf->Ln();
		foreach($this->getDataSource()->getParameter('arrayHijos') as $hijoDataSource) {
			$this->writeHijoUniCons($hijoDataSource, $pdf);
		}
		
		$this->writeProveedores($this->getDataSource()->getParameter('proveedorDataSource'), $pdf);
		
		$pdf->Ln(3);
		$this->writeDocumentacionTecnica($this->getDataSource()->getParameter('documentacionTecnicaDataSource'), $pdf);
		// $this->writeDocumentacionTecnica(new DataSource(), $pdf);
		
		$pdf->Ln();
		$hMedium = 10;
		$wHalf = 90;
		
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		//$pdf->setTextColor(234,0,0);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell(185, $height, 'OBSERVACIONES', 1, 1, 'C', true, '', 0, false, 'T', 'C');
		$pdf->setTextColor(0,0,0);
		$pdf->SetFont('', '');
		$pdf->MultiCell(185, $hMedium, $this->getDataSource()->getParameter('herramientasEspeciales'), 1, 'L', 0, 1, '', '', true, 0);
		//$pdf->Cell($w = 5, $h = $height, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(255,255,255);
		$pdf->SetFont('', 'B');
		$pdf->Cell(185, $height, 'OTROS DATOS TÉCNICOS', 1, 1, 'C', true, '', 0, false, 'T', 'C');
		$pdf->setTextColor(0,0,0);
		$pdf->SetFont('', '');
		$pdf->MultiCell(185, $hMedium, $this->getDataSource()->getParameter('otrosDatosTecnicos'), 1, 'L', 0, 1, '', '', true, 0);
		
		$pdf->SetFontSize(6.5);
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		//echo $this->getDataSource()->getParameter('otrosDatosTecnicos');exit;
		//$pdf->MultiCell($w = $wHalf, $h = $hMedium, $txt = $this->getDataSource()->getParameter('herramientasEspeciales'), $border = 0, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
		
		$pdf->MultiCell($w = 5, $h = $hMedium, $txt = '', $border = 0, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
		//$pdf->MultiCell($w = $wHalf, $h = $hMedium, $txt = $this->getDataSource()->getParameter('otrosDatosTecnicos'), $border = 1, $align = 'L', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 1, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
		
		
		/*$pdf->Ln();
		$pdf->Cell($w = 30, $h = $height, $txt = 'Observaciones', $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->MultiCell($w = 155, $h = $hMedium, $txt = $this->getDataSource()->getParameter('observaciones'), $border = 0, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);*/
		
		$pdf->Output($fileName, 'F');
	}

	function writePair(TCPDF $pdf, $value1, $widthVal1, $value2, $widthVal2, $pairSeparatorWidth, $height) {
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($widthVal1, $height, $value1, 0, 0, 'L', false, '', 0, false, 'T', 'C');
		if($pairSeparatorWidth > 0) {
			$pdf->Cell($pairSeparatorWidth, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		}
		
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);//$pdf->setTextColor(51,51,153);
		
		if($value1=='TAG'){
			$pdf->setTextColor(255,255,255);
			$pdf->SetFont('', 'B');
			$pdf->Cell($widthVal2, $height, $value2, 1, 0, 'C', true, '', 0, false, 'T', 'C');
			$pdf->setTextColor(0,0,0);
			$pdf->SetFont('', '');
		} else{
			$pdf->Cell($widthVal2, $height, $value2, 1, 0, 'C', false, '', 0, false, 'T', 'C');	
		}
		
	}
	
	function writeHijoUniCons(DataSource $dataSource, TCPDF $pdf) {
		
		if($dataSource->getParameter('ficha_tecnica')=='Si'){
			$pdf->Ln();
			$pdf->SetFontSize(7.5);
			$pdf->SetFont('', 'B');
			$height = 4;
			$pdf->SetFillColor(51,51,153, true);
			$pdf->setTextColor(255,255,255);
			$pdf->Cell(185, $height, $dataSource->getParameter('nombreUniConsHijo'), 1, 0, 'C', true, '', 0, false, 'T', 'C');
			$pdf->Ln();
			$height = 3;
			$pdf->SetFontSize(6.5);
			$pdf->SetFont('', '');
		
			foreach($dataSource->getDataset() as $row) {
				//Tabla
				$widthColVariable = 30;
				$widthColValor = 50;
				$widthSeparator = 15;
				$pdf->setTextColor(0,0,0);
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
		}
	}
	
	function writeRepuestos (DataSource $dataSource, TCPDF $pdf) {
		$widthMarginLeft = 0.01;
		$widthNombre = 60;
		$widthItem = 20;
		$widthObservaciones = 105;
		
		$pdf->Ln();
		$pdf->Ln();
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', '');
		$height = 4;
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		$pdf->Cell($widthNombre + $widthItem + $widthObservaciones, $height, 'REPUESTOS', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		
		$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		$pdf->Cell($widthNombre, $height, 'Nombre', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthItem, $height, 'Nº Item', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthObservaciones, $height, 'Observaciones', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		$pdf->setTextColor(0,0,0);
		$pdf->SetFontSize(6.5);
		$height = 3;
		foreach($dataSource->getDataset() as $row) {
			$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthNombre, $height, $row['nombre'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthItem, $height, $row['codigo'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthObservaciones, $height, $row['observaciones'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Ln();
		}
	}

	function writeProveedores(DataSource $dataSource, TCPDF $pdf) {
		$widthMarginLeft = 0;
		$widthDescripcion = 35;
		$widthParte = 15;
		$widthProveedor = 30;
		$widthContacto = 30;
		$widthDireccion = 40;
		$widthTelefono = 15;
		$widthEmail = 20;
		$totalWidth = $widthDescripcion + $widthParte + $widthProveedor + $widthContacto + $widthDireccion + $widthTelefono + $widthEmail;
		
		$pdf->Ln();
		//$pdf->Ln();
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		$height = 4;
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		if($widthMarginLeft > 0) {
			$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		}
		$pdf->Cell($totalWidth, $height, 'PROVEEDOR DE REPUESTOS', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		
		if ($widthMarginLeft > 0) {
			$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		}
		$pdf->Cell($widthDescripcion, $height, 'Descripción', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthParte+2, $height, 'NºParte/cod.', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthProveedor, $height, 'Proveedor', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthContacto, $height, 'Contacto', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthDireccion-2, $height, 'Dirección', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthTelefono, $height, 'Telefono', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthEmail, $height, 'Email', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		$pdf->setTextColor(0,0,0);
		$height = 3;
		$pdf->SetFontSize(6);
		
		/*foreach($dataSource->getDataset() as $row) {
			if ($widthMarginLeft > 0) {
				$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
			}
			$pdf->Cell($widthDescripcion, $height, $row['nombre'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthParte, $height, $row['codigo'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthProveedor, $height, $row['desc_proveedor'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthContacto, $height, $row['contacto'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthDireccion, $height, $row['direccion'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthTelefono, $height, $row['telefono1'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthEmail, $height, $row['email1'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
			$pdf->Ln();
		}*/
		$pdf->SetFont('', '');
		$anchos=array($widthDescripcion,$widthParte+2,$widthProveedor,$widthContacto,$widthDireccion-2,$widthTelefono,$widthEmail);
		$aligns=array('L','L','L','L','L','L','L');
		$pdf->MultiRow($dataSource->getDataset(),$anchos,$aligns,0,0);
	}

	function writeDocumentacionTecnica(DataSource $dataSource, TCPDF $pdf) {
		
		$wDocumento = 55;
		$wAdjunto = 15;
		$wCodigo = 15;
		$wObs = 100;
		$hNormal = 4;
		
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		//$pdf->setTextColor(234,0,0);
		
		$height = 4;
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		
		//$pdf->Cell($w = 185, $h = $hNormal, $txt = 'DOCUMENTACION TECNICA', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell(185, $height, 'DOCUMENTACIÓN TÉCNICA', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		//$pdf->setTextColor(0,0,0);

		$pdf->Cell($w = $wDocumento, $h = $hNormal, $txt = 'Documento', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wAdjunto, $h = $hNormal, $txt = 'Si/No', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wCodigo, $h = $hNormal, $txt = 'Código', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wObs, $h = $hNormal, $txt = 'Observaciones', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		
		//$pdf->SetFontSize(6.5);
		$pdf->SetFontSize(6);
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$hNormal=3;
		
		foreach($dataSource->getDataset() as $row) {
			$adjunto = null;
			$pdf->Cell($w = $wDocumento, $h = $hNormal, $txt = $row['nombre_documento'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			if ($row['adjunto'] == "true") {
				$adjunto = 'Si';
			} else {
				$adjunto = 'No';
			}
			$pdf->Cell($w = $wAdjunto, $h = $hNormal, $txt = $adjunto, $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			$pdf->Cell($w = $wCodigo, $h = $hNormal, $txt = $row['codigo'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			$pdf->Cell($w = $wObs, $h = $hNormal, $txt = $row['observaciones'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			$pdf->Ln();
		}
	}
}
?>