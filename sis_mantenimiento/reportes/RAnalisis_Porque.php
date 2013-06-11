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
        $this->Cell(105, $height/2, 'REGISTRO', 1, 2, 'C', false, '', 0, false, 'T', 'C');        
        $this->Cell(105,$height/2, 'ANÁLISIS PORQUE-PORQUE',1,0,'C',false,'',0,false,'T','C');
        
        $this->setXY($x+105,$y);
        $this->SetFont('','');
        $this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFontSize(7);
        
        $width1 = 17;
        $width2 = 23;
        $this->SetXY($x+105, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Código:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('codigo'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+105, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Revisión:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '1', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+105, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Fecha Emisión:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '29/06/2012', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+105, $y);
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

Class RAnalisisPorque extends Report {

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
        $width1 = 15;
        $width2 = 20;
        $width3 = 30;
        $width4 = 75;
        
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'No de Analisis:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width4, $height, $this->getDataSource()->getParameter('numero'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Localización:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width4, $height, $this->getDataSource()->getParameter('localizacion'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, 'Estación:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3, $height, ($this->getDataSource()->getParameter('estacion_planta')=='ESTACION'?'X':''), '1', 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, 'Planta:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3, $height, ($this->getDataSource()->getParameter('estacion_planta')=='PLANTA'?'X':''), '1', 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Máquina:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width4+$width3+$width1, $height, $this->getDataSource()->getParameter('id_uni_cons'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, 'TAG:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3, $height, $this->getDataSource()->getParameter('tag'), 'B', 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->Ln();
        
        $x=$pdf->getX();
        $y=$pdf->getY();
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Problema:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+$width4+$width2*3, $height*3, $this->getDataSource()->getParameter('problema'), '1', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetXY($x,$y+$height*4);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Fecha:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width4+$width3+$width1, $height, $this->getDataSource()->getParameter('fecha'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, 'Estado:', 0, 0, 'R', false, '', 0, false, 'T', 'C');        
        $pdf->SetFont('', 'B');
        $pdf->SetFillColor(51,51,153, true);
        $pdf->setTextColor(255,255,255);
        $x=$pdf->getX();
        $y=$pdf->getY();
        $pdf->Cell($width1, $height, 'En Proceso', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Terminado', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setXY($x,$y+$height);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, ($this->getDataSource()->getParameter('estado')=='En proceso'?'X':''), 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1, $height, ($this->getDataSource()->getParameter('estado')=='Terminado'?'X':''), 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Ln();
        
        $pdf->setTextColor(51,51,153);
        $pdf->SetFont('', 'B');
        $x=$pdf->getX();
        $y=$pdf->getY();        
        $pdf->Cell($width2, $height*3, 'Participantes:', 0, 0, 'R', false, '', 1, false, 'T', 'C');
        $x=$pdf->setXY($x+$width2,$y);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, 'Operador(es):', 0, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+$width1, $height, '1.'.$this->getDataSource()->getParameter('operador1'), 'B', 0, 'L', false, '', 1, false, 'T', 'C');        
        $pdf->Cell($width3+$width1, $height, '2.'.$this->getDataSource()->getParameter('operador2'), 'B', 0, 'L', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, 'Coordinador(es):', 0, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+$width1, $height, '1. '.$this->getDataSource()->getParameter('coordinador1'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $x=$pdf->setXY($x+$width2+$width1*2,$y+$height);
        $pdf->Cell($width3+$width1, $height, '3. '.$this->getDataSource()->getParameter('operador3'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');                
        $pdf->Cell($width3+$width1, $height, '4. '.$this->getDataSource()->getParameter('operador4'), 'B', 0, 'L', false, '', 1, false, 'T', 'C');
        $x=$pdf->setXY($x+$width3*4+$width2+$width1,$y+$height);
        $pdf->Cell($width3+$width1, $height, '2. '.$this->getDataSource()->getParameter('coordinador2'), 'B', 0, 'L', false, '', 1, false, 'T', 'C');
        $x=$pdf->setXY($x+$width2+$width1,$y+$height*2);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, 'Técnicos(os):', 0, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+$width1, $height, '1. '.$this->getDataSource()->getParameter('tecnico1'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->Cell($width3+$width1, $height, '2. '.$this->getDataSource()->getParameter('tecnico2'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->Cell($width3+$width1, $height, '3. '.$this->getDataSource()->getParameter('coordinador3'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');
        
        $dataset = $this->getDataSource()->getDataset();
        $pdf->Ln();
        $pdf->Ln();
        
        $this->writeDetalles($this->getDataSource()->getParameter('detalleDataSource'), $pdf);
        
        $this->writeSolucion($this->getDataSource()->getParameter('solucionDataSource'), $pdf);
        
        $pdf->Output($fileName, 'F');
    }
    
    function writeDetalles (DataSource $dataSource, TCPDF $pdf) {
        $widthMarginLeft = 1;
        $width = 5;
        $width3 = 30;
        $pdf->Ln();
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $height = 10;
        $pdf->SetFillColor(51,51,153, true);
        $pdf->setTextColor(255,255,255);
        
        $pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width3*2, $height, ' PORQUE?', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3*2+$width, $height, 'RESPUESTA', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3*2, $height, 'SOLUCION', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->SetFontSize(6.5);
        foreach($dataSource->getDataset() as $row) {
            $pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->MultiCell($width3*2, $height, $row['porque'], 1,'L', false ,0);
            $pdf->MultiCell($width3*2+$width, $height, $row['respuesta'], 1,'L', false ,0);
            $pdf->MultiCell($width3*2, $height, $row['solucion'], 1,'L', false ,1);
        }
    }

    function writeSolucion (DataSource $dataSource, TCPDF $pdf) {
        $widthMarginLeft = 1;
        $width1 = 20;
        $width2 = 105;
        
        $pdf->Ln();
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $height = 5;
        $pdf->SetFillColor(51,51,153, true);
        $pdf->setTextColor(255,255,255);        
        $pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width1*2, $height, 'Responsable', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, 'Descripcion', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Fecha', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Estatus', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->SetFontSize(6.5);
        foreach($dataSource->getDataset() as $row) {
            $pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width1*2, $height, $row['desc_funcionario1'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width2, $height, $row['descripcion'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width1, $height, $row['fecha'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width1, $height, $row['estado'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
            $pdf->Ln();
        }
    }    
}
?>