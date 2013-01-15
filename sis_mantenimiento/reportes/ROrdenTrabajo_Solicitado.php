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
        $this->Cell(30, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $this->Image(dirname(__FILE__).'/logo-ypfb-logistica.png', 16, 14, 28);
        
        $x = $this->GetX();
        $y = $this->GetY();
        $this->SetFontSize(14);
        $this->SetFont('','B');        
        $this->Cell(105, $height, ' SOLICITUD DE TRABAJO DE MANTENIMIENTO ', 1, 2, 'C', false, '', 1, false, 'T', 'C');    
        
        $this->setXY($x+105,$y);
        $this->SetFont('','');
        $this->Cell(50, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        
        $this->SetFontSize(7);
        
        $width1 = 17;
        $width2 = 33;
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
        $this->Cell($width2, $height/4, $this->dataSource->getParameter('fechaEmision'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
        
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

Class ROrdenTrabajoSolicitado extends Report {

    function write($fileName) {
        $pdf = new CustomReport('P', PDF_UNIT, "LEGAL", true, 'UTF-8', false);
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
        $dataset = $this->getDataSource()->getDataset();
        $gray = array('width' => 0.25, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(169, 169, 169));        
        $pdf->setLineStyle($gray);
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->setTextColor(0,0,0);        
        $pdf->setFillColor(220,220,220,true);
        $pdf->Cell($width2, $height, 'Fecha de Envio', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, 'Solicitado por:', 1, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'Cargo', 1, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, 'Fecha requerida', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, 'Sector', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, ' EQUIPO Nº /PROG/TAG ', 1, 0, 'C', true, '', 1, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'ECB', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        //var_dump($dataset);
        $pdf->Cell($width2, $height, $dataset[0]['fecha'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, $dataset[0]['desc_solicitante'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, $dataset[0]['nombre_cargo'], 1, 0, 'L', false, 'L', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, $dataset[0]['fecha_requerida'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, $dataset[0]['desc_localizacion'], 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width2, $height, $dataset[0]['desc_equipo'], 1, 0, 'C', false, '', 1, false, 'T', 'C');
        $pdf->Cell($width1, $height, $dataset[0]['ecb'], 1, 1, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->Cell($width2+$width1, $height, 'OBSERVACIÓN:', 1, 1, 'L', true, '', 0, false, 'T', 'C');
        $pdf->MultiCell(185,$height*3,$dataset[0]['observacion'],1,'J',false);
        $pdf->Ln($height);
        $pdf->Cell($width2*2+$width1, $height, 'DESCRIPCIÓN PUNTUAL DE LO QUE SE DESEA OBTENER:', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, '', 0, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width2*2+$width1, $height, 'CROQUIS ACTUAL', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $x=$pdf->getX();
        $y=$pdf->getY();
        $pdf->MultiCell($width2*3+$width1,$height*9,$dataset[0]['descripcion'],1,'J',false,0);
        $pdf->MultiCell($width2*2+$width1,$height*15,'',1,'J',false,0);        
        $pdf->setXY($x,$y+$height*9);
        
        $pdf->Cell($width2*3+$width1, $height, 'CANTIDAD REQUERIDA', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setXY($x,$y+$height*10);
        $pdf->Cell($width2*2, $height, 'DESCRIPCIÓN', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width1, $height, 'UNIDAD', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width2, $height, 'CANTIDAD', 1, 0, 'L', false, '', 0, false, 'T', 'C');
        $pdf->Ln($height*6);
        $checkBoxSi;
        $checkBoxNo;
        if($dataset[0]['inspeccion_lugar']=='si'){
            $checkBoxSi='<input type="checkbox" name="boxLugarSi" value="1" checked="checked">';
            $checkBoxNo='<input type="checkbox" name="boxLugarNo" value="1">';    
        }else{
            $checkBoxSi='<input type="checkbox" name="boxLugarSi" value="1">';
            $checkBoxNo='<input type="checkbox" name="boxLugarNo" value="1" checked="checked">';
        }
        $pdf->Cell($width2*3+$width1, $height, '        ¿Se inspeccionó en el lugar?           SI              NO', 1, 0, 'L', true, '', 0, false, 'T', 'C');
        //var_dump($dataset);
        $pdf->writeHTMLCell(5,5,$pdf->getX()-51,$pdf->getY()+1,"$checkBoxSi");        
        $pdf->writeHTMLCell(5,5,$pdf->getX()+ 9,$pdf->getY(),"$checkBoxNo");
        $x=$pdf->getX();
        $y=$pdf->getY();
        $pdf->setXY($x+32,$y-1);
        $pdf->Cell($width2*2+$width1, $height, '        ¿Se MARCO el lugar exacto?      SI              NO', 1, 0, 'L', true, '', 0, false, 'T', 'C');
        if($dataset[0]['inspeccion_exacto']=='si'){
            $checkBoxSi='<input type="checkbox" name="boxExacSi" value="1" checked="checked">';
            $checkBoxNo='<input type="checkbox" name="boxExacNo" value="1">';    
        }else{
            $checkBoxSi='<input type="checkbox" name="boxExacSi" value="1">';
            $checkBoxNo='<input type="checkbox" name="boxExacNo" value="1" checked="checked">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-25,$pdf->getY()+1,"$checkBoxSi");        
        $pdf->writeHTMLCell(5,5,$pdf->getX()+ 9,$pdf->getY(),"$checkBoxNo");
        $pdf->Ln($height*2);
        $pdf->setFillColor(50,135,215);
        
        $pdf->Cell($width2*2+$width1, $height, '¿Priorización SOLICITANTE?', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2*3+$width1, $height, 'Clase-Importancia del equipo:', 1, 1, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2*2+$width1, $height*8, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $x=$pdf->getX();
        $y=$pdf->getY();
        $pdf->SetFontSize(7);
        $text = "Clase A-Equipo cuya parada interrumpe el servicio, llevando a la facturación cesante.\nClase B-Equipo que participa del servicio pero que su parada por algún tiempo no interrumpe la producción.\nClase C-Equipo que no participa del servicio."; 
        $pdf->MultiCell($width2*3+$width1,$height*3,$text,1,'',false,0);
        $pdf->setXY($x,$y+$height*3);
        $pdf->SetFontSize(7.5);
        $pdf->Cell($width2*3+$width1, $height, 'PRIORIDAD', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setXY($x,$y+$height*4);
        $pdf->SetFontSize(7);
        $text = "Prioridad 1 - Emergencia - Mantenimiento que debe ser realizado inmediatamente después de detectada su necesidad.\nPrioridad 2 - Necesaria - Mantenimiento que puede ser postergado por algunos días pero que su ejecucion no debe superar un mes.\nPrioridad 3 - Deseable - Mantenimiento que puede ser postergado por algunas semanas (recomendable 4 ó 5) pero no debe ser omitido.";
        $pdf->MultiCell($width2*3+$width1,$height*4,$text,1,'',false,0);
        //prioridades
        $pdf->setXY($x-$width2*2-$width1,$y);
        $pdf->Ln($height);
        $pdf->Cell(29.5, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'Clase', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'Clase', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'Clase', 0, 1, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell(29.5, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'A', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'B', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'C', 0, 1, 'C', false, '', 0, false, 'T', 'C');
        //primera fila
        $xFilas=$pdf->getX();
        $yFilas=$pdf->getY();
        $pdf->Cell(13.5, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'Prioridad 1', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setFillColor(255,0,0);
        $pdf->Cell(16, $height, '1', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        $colorUno;
        $colorDos;
        $colorTres;
        $checkBox;
        if($dataset[0]['prioridad']==1){
            $colorUno=255;
            $colorDos=0;
            $colorTres=0;
            $checkBox='<input type="checkbox" name="mybox" value="1" checked="checked">';    
        }else{
            $checkBox='<input type="checkbox" name="mybox" value="1" checked="unchecked">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas+45.5,$yFilas);
        $pdf->setFillColor(255,153,0);
        $pdf->Cell(16, $height, '4', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        if($dataset[0]['prioridad']==4){
            $colorUno=255;
            $colorDos=153;
            $colorTres=0;
            $checkBox='<input type="checkbox" name="mybox2" value="1" checked="checked">';    
        }else{
            $checkBox='<input type="checkbox" name="mybox2" value="1">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas+61.5,$yFilas);
        $pdf->setFillColor(102,255,102);
        $pdf->Cell(16, $height, '7', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        if($dataset[0]['prioridad']==7){
            $colorUno=102;
            $colorDos=255;
            $colorTres=102;
            $checkBox='<input type="checkbox" name="mybox3" value="1" checked="checked">';    
        }else{
            $checkBox='<input type="checkbox" name="mybox3" value="1">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas,$yFilas+$height);
        //segunda fila
        $pdf->setFillColor(50,135,215);
        $pdf->Cell(13.5, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'Prioridad 2', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setFillColor(255,102,51);
        $pdf->Cell(16, $height, '2', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        if($dataset[0]['prioridad']==2){
            $colorUno=255;
            $colorDos=102;
            $colorTres=51;
            $checkBox='<input type="checkbox" name="mybox4" value="1" checked="checked">';    
        }else{
            $checkBox='<input type="checkbox" name="mybox4" value="1">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas+45.5,$yFilas+$height);
        $pdf->setFillColor(255,255,0);
        $pdf->Cell(16, $height, '5', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        if($dataset[0]['prioridad']==5){
            $colorUno=255;
            $colorDos=255;
            $colorTres=0;
            $checkBox='<input type="checkbox" name="mybox5" value="1" checked="checked">';
        }else{
            $checkBox='<input type="checkbox" name="mybox5" value="1">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas+61.5,$yFilas+$height);
        $pdf->setFillColor(51,204,51);
        $pdf->Cell(16, $height, '8', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        if($dataset[0]['prioridad']==8){
            $colorUno=51;
            $colorDos=204;
            $colorTres=51;
            $checkBox='<input type="checkbox" name="mybox6" value="1" checked="checked">';    
        }else{
            $checkBox='<input type="checkbox" name="mybox6" value="1">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas,$yFilas+$height*2);
        //tercera fila
        $pdf->setFillColor(50,135,215);
        $pdf->Cell(13.5, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, 'Prioridad 3', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setFillColor(255,153,102);
        $pdf->Cell(16, $height, '3', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        if($dataset[0]['prioridad']==3){
            $colorUno=255;
            $colorDos=153;
            $colorTres=102;
            $checkBox='<input type="checkbox" name="mybox7" value="1" checked="checked">';
        }else{
            $checkBox='<input type="checkbox" name="mybox7" value="1">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas+45.5,$yFilas+$height*2);
        $pdf->setFillColor(204,255,153);
        $pdf->Cell(16, $height, '6', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        if($dataset[0]['prioridad']==6){
            $colorUno=204;
            $colorDos=255;
            $colorTres=153;
            $checkBox='<input type="checkbox" name="mybox8" value="1" checked="checked">';
        }else{
            $checkBox='<input type="checkbox" name="mybox8" value="1">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas+61.5,$yFilas+$height*2);
        $pdf->setFillColor(51,153,51);
        $pdf->Cell(16, $height, '9', 0, 0, 'C', true, '', 0, false, 'T', 'C');
        if($dataset[0]['prioridad']==9){
            $colorUno=51;
            $colorDos=153;
            $colorTres=51;
            $checkBox='<input type="checkbox" name="mybox9" value="1" checked="checked">';
        }else{
            $checkBox='<input type="checkbox" name="mybox9" value="1">';
        }
        $pdf->writeHTMLCell(5,5,$pdf->getX()-6,$pdf->getY()+1,"$checkBox");
        $pdf->setXY($xFilas,$yFilas+$height*2);
        $pdf->Ln($height*2);
        $pdf->Cell(29.5, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->setFillColor(220,220,220);
        $pdf->Cell(16, $height, 'PRIORIDAD', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setFillColor($colorUno,$colorDos,$colorTres);
        $pdf->Cell(16, $height, $dataset[0]['prioridad'], 1, 1, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->setFillColor(102,102,51);
        $pdf->Cell($width2*5+$width1*2, $height, 'MANTENIMIENTO', 1, 1, 'C', true, '', 0, false, 'T', 'C');
        $pdf->setFillColor(220,220,220);
        $pdf->Cell($width2*2+$width1, $height, 'OBSERVACIONES JEFE DE MANTENIMIENTO', 1, 0, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Cell($width2*3+$width1, $height, 'OBSERVACIONES RESPONSABLE: '.$dataset[0]['desc_responsable'], 1, 1, 'C', true, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->Cell($width2+16, $height, 'El trabajo debe ser atendido por:', 1, 0, 'R', true, '', 1, false, 'T', 'C');
        $pdf->Cell(32, $height, $dataset[0]['nombre_uo'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width2+16, $height, 'FECHA DE ENTREGA TENTATIVA OIT', 1, 0, 'R', true, '', 1, false, 'T', 'C');
        $pdf->Cell(32, $height, $dataset[0]['fecha_estimada'], 1, 1, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->Cell($width2+16, $height, 'RESPONSABLE ELABORACIÓN OIT/OTT:', 1, 0, 'R', true, '', 1, false, 'T', 'C');
        $pdf->Cell(32, $height, $dataset[0]['desc_responsable'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width2+16, $height, 'FECHA DE ENTREGA REAL OIT', 1, 0, 'R', true, '', 1, false, 'T', 'C');
        $pdf->Cell(32, $height, $dataset[0]['fecha_real'], 1, 1, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $pdf->Cell($width2+16, $height, 'FECHA DE RECEPCIÓN', 1, 0, 'R', true, '', 1, false, 'T', 'C');
        $pdf->Cell(32, $height, $dataset[0]['fecha_recepcion'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell(16, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Cell($width2+16, $height, 'LE CORRESPONDE OIT/OTT Nº:', 1, 0, 'R', true, '', 1, false, 'T', 'C');
        $pdf->Cell(32, $height, $dataset[0]['codigo_uo'], 1, 1, 'C', false, '', 0, false, 'T', 'C');
        $pdf->Ln();
        $checkBoxAlta;
        $checkBoxMedia;
        $checkBoxBaja;
        if($dataset[0]['importancia']=='Alta'){
            $checkBoxAlta='<input type="checkbox" name="boxAlta" value="1" checked="checked">';
        }else{
            $checkBoxAlta='<input type="checkbox" name="boxAlta" value="1">';
        }
        if($dataset[0]['importancia']=='Media'){
            $checkBoxMedia='<input type="checkbox" name="boxMedia" value="1" checked="checked">';
        }else{
            $checkBoxMedia='<input type="checkbox" name="boxMedia" value="1">';
        }
        if($dataset[0]['importancia']=='Baja'){
            $checkBoxBaja='<input type="checkbox" name="boxBaja" value="1" checked="checked">';
        }else{
            $checkBoxBaja='<input type="checkbox" name="boxBaja" value="1">';
        }
        $pdf->Cell($width2, $height, 'IMPORTANCIA', 1, 0, 'R', true, '', 1, false, 'T', 'C');
        $pdf->Cell(16, $height, 'ALTA', 1, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->writeHTMLCell(5,5,$pdf->getX()-7,$pdf->getY()+1,"$checkBoxAlta");
        $pdf->setXY($pdf->getX()+2,$pdf->getY()-1);
        $pdf->Cell(16, $height, 'MEDIA', 1, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->writeHTMLCell(5,5,$pdf->getX()-7,$pdf->getY()+1,"$checkBoxMedia");
        $pdf->setXY($pdf->getX()+2,$pdf->getY()-1);        
        $pdf->Cell(16, $height, 'BAJA', 1, 0, 'L', true, '', 0, false, 'T', 'C');
        $pdf->writeHTMLCell(5,5,$pdf->getX()-7,$pdf->getY()+1,"$checkBoxBaja");
        $pdf->setXY($pdf->getX()+2,$pdf->getY()-1);        
        $pdf->Cell(16, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
        $x=$pdf->getX();
        $y=$pdf->getY();        
        $pdf->Cell($width2*3, $height*5, '', 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->setXY($x,$y);
        $pdf->Cell($width2+16, $height, 'OBSERVACIONES DEL RESPONSABLE:', 0, 1, 'R', true, '', 1, false, 'T', 'C');
        $x=$pdf->getX();
        $y=$pdf->getY();
        $pdf->Cell($width2*3+4, $height, '', 0, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->MultiCell($width2*3,$height*4,$dataset[0]['observaciones_resp'],0,'J',false,0);
        $pdf->setXY($x,$y+$height);        
        $pdf->Cell($width2*2+$width1, $height*3, '', 1, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->setXY($x,$y+$height);
        $pdf->Cell(13.5, $height, 'NOTA.-', 0, 0, 'R', true, '', 1, false, 'T', 'C');
        $pdf->Cell(16, $height, '', 0, 0, 'R', false, '', 1, false, 'T', 'C');
        $pdf->Cell(16*3, $height, '¿SOLICITUD RECHAZADA? SI     NO', 1, 0, 'L', true, '', 1, false, 'T', 'C');
        $pdf->writeHTMLCell(4,4,$pdf->getX()-12,$pdf->getY()+1,'<input type="checkbox" name="boxSoliSi" value="1">');
        $pdf->writeHTMLCell(4,4,$pdf->getX()+3,$pdf->getY(),'<input type="checkbox" name="boxSoliNo" value="1">');
        $pdf->Ln();
        $pdf->MultiCell($width2*2+$width1,$height*2,$dataset[0]['nota'],0,'L',false,0);
        $pdf->Ln($height*3);
        $pdf->MultiCell($width2*4,$height,'SEÑOR '.$dataset[0]['desc_solicitante']." FAVOR IMPRIMIR, HACER FIRMAR CON EL JEFE DE MANTENIMIENTO Y ARCHIVAR JUNTO A OIT/OTT GENERADA",0,'C',true,0);
        $pdf->Cell($width1, $height, '', 0, 0, 'R',false, '', 1, false, 'T', 'C');
        $pdf->setXY($pdf->getX(),$pdf->getY()+$height);
        $pdf->Cell($width2+$width1, $height, 'FIRMA JMOC', 'T', 0, 'C',false, '', 1, false, 'T', 'C');
        $pdf->Output($fileName, 'F');
    }
    
}
?>