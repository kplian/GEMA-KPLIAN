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
        $this->Cell(170,$height/2, 'PLAN DE MANTENIMIENTO RCM',1,0,'C',false,'',0,false,'T','C');
        
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
}

Class RPlan_Mant extends Report {

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
        $width1 = 6;
        $width2 = 20;
        $width3 = 40;
        $width4 = 100;
        
		$pdf->SetXY(PDF_MARGIN_LEFT, 30);
		
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Localizacion:', 'L', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width4+130, $height, $this->getDataSource()->getParameter('localizacion'), 'R', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Sistema:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*5, $height, $this->getDataSource()->getParameter('nombre_sis'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*2, $height*2, 'TAG:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*6, $height*2, $this->getDataSource()->getParameter('tag'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Preparado por:', 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+36, $height, $this->getDataSource()->getParameter('preparado_por'), 'T', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Fecha:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*7, $height, $this->getDataSource()->getParameter('fecha_emi'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Subsistema:', 1, 0, 'L', false, '', 1, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*5, $height, $this->getDataSource()->getParameter('nombre_sub'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $x=$pdf->getX();
        $y=$pdf->getY();
        $pdf->setXY($x+$width1*8,$y);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Revisado por:', 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+36, $height, $this->getDataSource()->getParameter('revisado_por'), 'T', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Fecha:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*7, $height, $this->getDataSource()->getParameter('fecha_rev'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        
        
        $dataset = $this->getDataSource()->getDataset();
        
                
        // end title
        
        $colCount = 0;
        $pdf->SetFontSize(6.5);        
        $this->writeTarea($this->getDataSource()->getParameter('tareaDataSource'), $pdf);
        
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
    
    function writeTarea (DataSource $dataSource, TCPDF $pdf) {
        $widthMarginLeft = 1;
        $width = 6;
        
        $pdf->Ln();
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $height = 5;
        $pdf->SetFillColor(51,51,153, true);
        $pdf->setTextColor(255,255,255);
        
        $x = $pdf->getX();
        $y = $pdf->getY();        
        $pdf->Cell($width*3, $height, 'Referencia de información', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width*4, $height, 'Evaluación de secuencias', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height*2, 'H1 S1 O1 N1', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height*2, 'H2 S2 O2 N2', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height*2, 'H3 S3 O3 N3', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width*3, $height, 'Tareas a falta de', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width*2+100, $height*2, 'Tareas de mantenimiento', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width*3, $height*2, 'Frecuencia inicial', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width*7, $height*2, 'Realizado por: ', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        
        $pdf->setXY($x,$y+$height);
        $pdf->Cell($width, $height, 'F', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height, 'FF', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height, 'MF', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height, 'H', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height, 'S', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height, 'O', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height, 'N', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $x = $pdf->getX();
        $y = $pdf->getY();
        $pdf->setXY($x+$width*3,$y);
        $pdf->Cell($width, $height, 'H4', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height, 'H5', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width, $height, 'S4', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Ln();
        
        $pdf->setTextColor(0,0,0);
        $pdf->SetFontSize(6.5);
        foreach($dataSource->getDataset() as $row) {
            $pdf->Cell($width, $height, $row['funcion'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['funcion_falla'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['modo_falla'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_h'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_s'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_o'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_n'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_hson1'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_hson2'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_hson3'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_h4'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_h5'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['col_s4'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width*2+100, $height, $row['tareas'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width*3, $height, $row['frecuencia'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width*7, $height, $row['nombre_especialidad'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Ln();
        }
    }    
}
?>