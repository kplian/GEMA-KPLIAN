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
        $this->SetFontSize(12);
        $this->SetFont('','');        
        $this->Cell(245, $height/3, 'PRESUPUESTO DE MANTENIMIENTO OPERATIVO', 1, 2, 'C', false, '', 1, false, 'T', 'C');        
        $this->setXY($x,$y+$height/3);
        $this->Cell(245, $height/3, 'PLANTAS DE ALMACENAJE BOLIVIA',1,0,'C',false,'',1,false,'T','C');
        $this->setXY($x,$y+$height*2/3);
        $this->Cell(245, $height/3, '['.$this->dataSource->getParameter('moneda').']',1,0,'C',false,'',1,false,'T','C');
        
        $this->setXY($x+245,$y);
        $this->SetFont('','');
        $this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFontSize(7);
        
        $width1 = 17;
        $width2 = 23;
        $this->SetXY($x+245, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Registro:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+245, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Emisión:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+245, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Revisión:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFont('','');
        $y += 5;
        $this->SetXY($x+245, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height/4, 'Preparado:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('','B');
        $this->Cell($width2, $height/4, '', "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
    }
    
    public function Footer() {
        //TODO: implement the footer manager
    }
}

Class RPresupuesto extends Report {

    function write($fileName) {
        $pdf = new CustomReport('L', PDF_UNIT, "LEGAL", true, 'UTF-8', false);
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
        
        $height = 10;        
        $width1 = 5;
        $width2 = 10;
        $width3 = 20;
        
        $dataset = $this->getDataSource()->getParameter('presupuestoDataSource');
        $widthMarginLeft = 1;
        $pdf->Ln();
        $pdf->Ln();
        //Detalle de la unidad constructiva
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->SetFillColor(51,51,153, true);
        $pdf->setTextColor(255,255,255);
        $pdf->Cell($width2, $height, 'Centro Costo', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width3+$width2+$width1, $height, 'Descripcion', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, 'Presup', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $x = $pdf->getX();
        $y = $pdf->getY();
        $pdf->Cell($width3, $height/2, 'Enero', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Febrero', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Marzo', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Abril', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Mayo', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Junio', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Julio', 1, 0, 'C', true, '', 0, false, 'T', 'C');        
        $pdf->Cell($width3, $height/2, 'Agosto', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Septiembre', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Octubre', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Noviembre', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3, $height/2, 'Diciembre', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width3+$width2, $height/2, 'Total', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setXY($x,$y+$height/2);
        for($i=0; $i<13;$i++){
            $pdf->Cell($width3/2, $height/2, 'Prog.', 1, 0, 'C', true, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height/2, 'Ejec.', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        }        
        $pdf->Cell($width2, $height/2, '%', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        // end title
        
        $pdf->setTextColor(0,0,0);
        $pdf->SetFontSize(6.5);
        $totalPresupEne = 0;
        $totalEjecEne = 0;
        $totalPresupFeb = 0;
        $totalEjecFeb = 0;
        $totalPresupMar = 0;
        $totalEjecMar = 0;
        $totalPresupAbr = 0;
        $totalEjecAbr = 0;
        $totalPresupMay = 0;
        $totalEjecMay = 0;
        $totalPresupJun = 0;
        $totalEjecJun = 0;
        $totalPresupJul = 0;
        $totalEjecJul = 0;
        $totalPresupAgo = 0;
        $totalEjecAgo = 0;
        $totalPresupSep = 0;
        $totalEjecSep = 0;
        $totalPresupOct = 0;
        $totalEjecOct = 0;
        $totalPresupNov = 0;
        $totalEjecNov = 0;
        $totalPresupDic = 0;
        $totalEjecDic = 0;
        $totalPresupuestado = 0;
        $totalEjecutado = 0;
        foreach($dataset->getDataSet() as $row) {      
            //Tabla
            //$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width2, $height, $row['centro_costo'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3+$width2+$width1, $height, $row['codigo_par'], 1, 0, 'L', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width2, $height, $row['codigo_pres'], 1, 0, 'R', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_ene'], 1, 0, 'R', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_ene'], 1, 0, 'R', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_feb'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_feb'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_mar'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_mar'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_abr'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_abr'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_may'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_may'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_jun'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_jun'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_jul'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_jul'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_ago'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_ago'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_sep'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_sep'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_oct'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_oct'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_nov'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_nov'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['presup_dic'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, $row['ejec_dic'], 1, 0, 'R', false, '', 0, false, 'T', 'C');
            $totalPartidaPresup = $row['presup_ene']+$row['presup_feb']+$row['presup_mar']+$row['presup_abr']+
                           $row['presup_may']+$row['presup_jun']+$row['presup_jul']+$row['presup_ago']+
                           $row['presup_sep']+$row['presup_oct']+$row['presup_nov']+$row['presup_dic'];
            $totalPartidaEjec = $row['ejec_ene']+$row['ejec_feb']+$row['ejec_mar']+$row['ejec_abr']+
                           $row['ejec_may']+$row['ejec_jun']+$row['ejec_jul']+$row['ejec_ago']+
                           $row['ejec_sep']+$row['ejec_oct']+$row['ejec_nov']+$row['ejec_dic'];            
            $pdf->Cell($width3/2, $height, number_format($totalPartidaPresup,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, number_format($totalPartidaEjec,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
            $pdf->Cell($width3/2, $height, number_format($totalPartidaEjec*100/$totalPartidaPresup,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
            $pdf->Ln();
            $totalPresupEne = $totalPresupEne+$row['presup_ene'];
            $totalEjecEne = $totalEjecEne+$row['ejec_ene'];
            $totalPresupFeb = $totalPresupFeb+$row['presup_feb'];
            $totalEjecFeb = $totalEjecFeb+$row['ejec_feb'];
            $totalPresupMar = $totalPresupMar+$row['presup_mar'];
            $totalEjecMar = $totalEjecMar+$row['ejec_mar'];
            $totalPresupAbr = $totalPresupAbr+$row['presup_abr'];
            $totalEjecAbr = $totalEjecAbr+$row['ejec_abr'];
            $totalPresupMay = $totalPresupMay+$row['presup_may'];
            $totalEjecMay = $totalEjecMay+$row['ejec_may'];
            $totalPresupJun = $totalPresupJun+$row['presup_jun'];
            $totalEjecJun = $totalEjecJun+$row['ejec_jun'];
            $totalPresupJul = $totalPresupJul+$row['presup_jul'];
            $totalEjecJul = $totalEjecJul+$row['ejec_jul'];
            $totalPresupAgo = $totalPresupAgo+$row['presup_ago'];
            $totalEjecAgo = $totalEjecAgo+$row['ejec_ago'];
            $totalPresupSep = $totalPresupSep+$row['presup_sep'];
            $totalEjecSep = $totalEjecSep+$row['ejec_sep'];
            $totalPresupOct = $totalPresupOct+$row['presup_oct'];
            $totalEjecOct = $totalEjecOct+$row['ejec_oct'];
            $totalPresupNov = $totalPresupNov+$row['presup_nov'];
            $totalEjecNov = $totalEjecNov+$row['ejec_nov'];
            $totalPresupDic = $totalPresupDic+$row['presup_dic'];
            $totalEjecDic = $totalEjecDic+$row['ejec_dic'];
            $totalPresupuestado = $totalPresupuestado + $totalPartidaPresup;
            $totalEjecutado = $totalEjecutado + $totalPartidaEjec;          
        }        
        $pdf->Cell($width3*2+$width1, $height, 'TOTAL [$US]', 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width2, $height, '', 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupEne,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecEne,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupFeb,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecFeb,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupMar,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecMar,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupAbr,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecAbr,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupMay,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecMay,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupJun,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecJun,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupJul,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecJul,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupAgo,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecAgo,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupSep,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecSep,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupOct,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecOct,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupNov,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecNov,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupDic,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecDic,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalPresupuestado,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecutado,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width3/2, $height, number_format($totalEjecutado*100/$totalPresupuestado,2), 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Ln();        
        
        $pdf->Output($fileName, 'F');
    }
    
    
}
?>