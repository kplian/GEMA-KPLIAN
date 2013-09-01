<?php
require_once dirname(__FILE__).'/pxpReport/Report.php';

class CustomReportGI extends TCPDF {
	private $titulo;
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
		
		$this->SetFontSize(12);
		$this->SetFont('','B');
		$this->Cell(115, $height/2, 'REGISTRO', 1, 2, 'C', false, '', 0, false, 'T', 'C');        
        $this->Cell(115,$height/2, 'Indicadores de Mantenimiento',1,0,'C',false,'',0,false,'T','C');
		$this->setXY($x+115,$y);
        $this->SetFont('','');
        $this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        
        $this->SetFontSize(7);
        
        $width1 = 17;
        $width2 = 23;
        $this->SetXY($x+145, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Código:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, 'GMAN-RG-SM-028', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
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
        $this->SetXY($x+115, $y);
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
	
	function setTitulo($pTitulo){
		$this->titulo = $pTitulo;
	}
}

class RGraficoIndicadores extends Report {
	private $titulo;

    function write($fileName) {
    	
        $pdf = new CustomReportGI('P', PDF_UNIT, "LETTER", true, 'UTF-8', false);
		$pdf->setTitulo($this->titulo);
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
        $width1 = 17.5;
        $width2 = 30;
        $width3 = 30;
        $width4 = 75;
        $dataSource = $this->getDataSource();
        $gray = array('width' => 0.25, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(169, 169, 169));        
        $pdf->setLineStyle($gray);
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);        
        $pdf->setFillColor(220,220,220,true);
        $pdf->Cell($width2-10, $height, 'Localización:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', '');
		$pdf->Cell($width2+40, $height, $dataSource->getParameter('localizacion'), 1, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
        $pdf->Cell($width2-17, $height, 'Sistema:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', '');
		$pdf->Cell($width2+51, $height, $dataSource->getParameter('equipo'), 1, 1, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
        $pdf->Cell($width1+2.5, $height, 'Desde:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', '');
		$pdf->Cell($width1+5, $height, $dataSource->getParameter('fecha_ini'), 1, 0, 'C', false, 'L', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
        $pdf->Cell($width1, $height, 'Hasta:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', '');
		$pdf->Cell($width1+5, $height, $dataSource->getParameter('fecha_fin'), 1, 0, 'C', false, '', 0, false, 'T', 'C');
		$pdf->Cell($width2-22, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
        $pdf->Cell($width2-17.4, $height, 'TAG:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', '');
		$pdf->Cell($width2+51, $height, $dataSource->getParameter('tag'), 1, 0, 'L', false, '', 1, false, 'T', 'C');
        $pdf->Ln();
		$pdf->Ln();
		$pdf->SetFont('', 'B');
		$pdf->SetFillColor(25,25,112);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 90.1, $h = $hGlobal, $txt = $dataSource->getParameter('titulo_det'), $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		
		//var_dump($dataSource->getParameter('detalle')->getDataset());exit;
		
		$wHHNormal = 20;
		$wHHExtras = 30;
		$wExtMov = 20;
		$wNombre = 40;
		$wCargo = 45;
		$wObservaciones = 40;
		$counter = 0;
		$pdf->SetFont('', 'B');

		//var_dump($dataSource->getParameter('detalle'));exit;
		if($dataSource->getParameter('tipo_indicador')=='ejecucion'){
			$pdf->Cell($width1,    $height, 'Mes',         1, 0, 'C', true, '', 0, true, 'T', 'C');
			$pdf->Cell($width1+19, $height, 'Planificado', 1, 0, 'C', true, '', 0, true, 'T', 'C');
			$pdf->Cell($width1+19, $height, 'Ejecutado',   1, 1, 'C', true, '', 0, true, 'T', 'C');
			$pdf->setTextColor(0,0,0);
			foreach($dataSource->getParameter('detalle') as $datarow) {
				$pdf->Cell($width1,    $height, $datarow['tipo'],      1, 0, 'C', false, '', 0, true, 'T', 'C');
				$pdf->Cell($width1+19, $height, $datarow['total_pla'], 1, 0, 'C', false, '', 0, true, 'T', 'C');
				$pdf->Cell($width1+19, $height, $datarow['total_eje'], 1, 1, 'C', false, '', 0, true, 'T', 'C');
			}
			
		} else {
			foreach($dataSource->getParameter('detalle') as $datarow) {
				$pdf->MultiCell($w = $wHHExtras, $h = $hMedium, $txt = $datarow['tipo'], $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			}
			$pdf->Ln();
			$pdf->SetFont('', '');
			$pdf->setTextColor(0,0,0);
			foreach($dataSource->getParameter('detalle') as $datarow) {
				$pdf->MultiCell($w = $wHHExtras, $h = $hMedium, $txt = number_format($datarow['total'],2), $border = 1, $align = 'R', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			}
		}

		//Despliega el gráfico
		$x = 40;
		$y = $pdf->GetY()+20;
		if($dataSource->getParameter('nombre_archivo_grafico')!=''){
			$pdf->Image($dataSource->getParameter('nombre_archivo_grafico'), $x, $y, 0,0,'','','C',true,500,'',false,false,1);
		}
		
		$pdf->Ln(120);
		$pdf->SetFont('', 'B');
		$pdf->SetFillColor(25,25,112);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell(185,    7, 'OBSERVACIONES',      1, 1, 'C', true, '', 0, true, 'T', 'C');
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->MultiCell($w = 185, $h = 50, $txt = $dataSource->getParameter('observaciones'), $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		
		
        $pdf->Output($fileName, 'F');
    }

	function setTitulo($pTitulo){
		$this->titulo = $pTitulo;
	}

}
?>