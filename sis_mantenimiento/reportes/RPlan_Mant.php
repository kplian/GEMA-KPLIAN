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
        $this->Cell(42, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $this->Image(dirname(__FILE__).'/logo-ypfb-logistica.png', 16, 12, 36);
        
        $x = $this->GetX();
        $y = $this->GetY();
        $this->SetFontSize(14);
        $this->SetFont('','B');       
        $this->Cell(166,$height, 'PLAN DE MANTENIMIENTO RCM',1,0,'C',false,'',0,false,'T','C');
        
        $this->setXY($x+166,$y);
        $this->SetFont('','');
        $this->Cell(42, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        
        $this->SetFontSize(7);
        
        $width1 = 17;
        $width2 = 23;
        $this->SetXY($x+166, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Codigo:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('codigo'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+166, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Revision:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('id_plan_mant'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+166, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Fecha Emision:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('fechaEmision'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+166, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Página:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->PageNo().' de '.$this->getNumPages(), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
    }
    
    public function Footer() {
        //TODO: implement the footer manager
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
        
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2, $height, 'Localizacion:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width4, $height, $this->getDataSource()->getParameter('localizacion'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');        
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Sistema:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*5, $height, $this->getDataSource()->getParameter('nombre_sistema'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*2, $height*2, 'TAG:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*6, $height*2, $this->getDataSource()->getParameter('tag'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Preparado por:', 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+36, $height, $this->getDataSource()->getParameter('nombre_preparador'), 'T', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Fecha:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*7, $height, $this->getDataSource()->getParameter('fecha_preparado'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Subsistema:', 1, 0, 'L', false, '', 1, false, 'T', 'C');
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*5, $height, $this->getDataSource()->getParameter('nombre_subsistema'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $x=$pdf->getX();
        $y=$pdf->getY();
        $pdf->setXY($x+$width1*8,$y);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Revisado por:', 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3+36, $height, $this->getDataSource()->getParameter('nombre_revisor'), 'T', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1*3, $height, 'Fecha:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width1*7, $height, $this->getDataSource()->getParameter('fecha_revisado'), 1, 0, 'C', false, '', 1, false, 'T', 'C');
        
        
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
        $pdf->Cell($width*3, $height, 'Referencia de informacion', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width*4, $height, 'Evaluacion de secuencias', 1, 0, 'C', true, '', 1, false, 'T', 'C');
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
            $pdf->Cell($width, $height, $row[''], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width, $height, $row[''], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width, $height, $row['id_modo_falla'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
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