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
        $this->Cell(105,$height/2, 'PLANILLA DE ANALISIS RCM',1,0,'C',false,'',0,false,'T','C');
        
        $this->setXY($x+105,$y);
        $this->SetFont('','');
        $this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        
        $this->SetFontSize(7);
        
        $width1 = 17;
        $width2 = 23;
        $this->SetXY($x+105, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Codigo:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('codigo'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+105, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Revision:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('revision'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+105, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Fecha Emision:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('fecha_emision'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+105, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Página:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, $this->PageNo().' de '.$this->getNumPages(), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
    }
    
    public function Footer() {
        //TODO: implement the footer manager
    }
}

Class RAnalisisMant extends Report {

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
        $pdf->Cell($width3, $height*2, '', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setXY($x,$y);
        $pdf->Cell($width1, $height, 'Sistema:', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width2+$height, $height, $this->getDataSource()->getParameter('nombre_sis'), 'B', 0, 'C', false, '', 1, false, 'T', 'C');        
        $pdf->setXY($x,$y+$height);
        $pdf->setTextColor(0,0,0);   
        $pdf->Cell($width1, $height, 'Subsistema:', 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width2+$height, $height, $this->getDataSource()->getParameter('nombre_sub'), 'T', 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->setXY($x+$width3,$y);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width2/2, $height*2, 'TAG:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3, $height*2, 'nombre tag', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $x=$pdf->getX();
        $y=$pdf->getY();        
        $pdf->Cell($width3+$width1-5, $height*2, '', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setXY($x,$y);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1, $height, 'Preparado por:', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3-5, $height, 'nombre preparador', 'B', 0, 'C', false, '', 0, false, 'T', 'C');        
        $pdf->setXY($x,$y+$height);
        $pdf->setTextColor(0,0,0);   
        $pdf->Cell($width1, $height, 'Revisado por:', 'T', 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width3-5, $height, $this->getDataSource()->getParameter('desc_funcionario1'), 'T', 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->setXY($x+$width1+$width3-5,$y);
        $pdf->setTextColor(0,0,0);
        $pdf->Cell($width1+5, $height, 'Fecha:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width2+5, $height, $this->getDataSource()->getParameter('fecha_emision'), 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->setXY($x+$width1+$width3-5,$y+$height);
        $pdf->setTextColor(0,0,0);        
        $pdf->Cell($width1+5, $height, 'Fecha:', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->setTextColor(51,51,153);
        $pdf->Cell($width2+5, $height, $this->getDataSource()->getParameter('fecha_rev'), 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        $dataset = $this->getDataSource()->getDataset();
        $pdf->Ln();
        $pdf->Ln();
                
        // end title
        
        $colCount = 0;
        $pdf->SetFontSize(6.5);
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
        
        $pdf->Cell($width*8, $height, 'FUNCION', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width*10, $height, 'FALLA FUNCIONAL', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width*10, $height, 'MODOS DE FALLA (Causa de la falla)', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width*9, $height, 'EFECTOS DE FALLA (Que sucede cuando falla)', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setTextColor(0,0,0);
        $pdf->SetFontSize(6.5);
        $x=$pdf->getX();
        $y=$pdf->getY();
        $distance=0;        
        foreach($dataSource->getDataset() as $row) {
            $pdf->setXY($x,$y+($distance*$height*10));
            $pdf->Cell($width*8, $height*10, $row['descripcion'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            
            $xfalla=$pdf->getX();
            $yfalla=$pdf->getY();            
            $numFallas=count($row['dataset']->getDataset());
            if($numFallas!==0)
                $intervaloFallas=50/$numFallas;
            $distanciaFalla=0;                                  
            foreach ($row['dataset']->getDataset() as $falla) {
                
                $pdf->setXY($xfalla,$yfalla+$intervaloFallas*$distanciaFalla);
                $pdf->Cell($width*10, $intervaloFallas, $falla['modo_falla'], 1, 0, 'C', false, '', 0, false, 'T', 'C');                    
                
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
            }
            $distance++;
        }
    }    
}
?>