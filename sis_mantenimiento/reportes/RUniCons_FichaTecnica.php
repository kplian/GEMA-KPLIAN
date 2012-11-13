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
		//TODO: implement the heder manager
		
		//$this->SetY(10);
		$height = 20;
		$x = $this->GetX();
		$y = 20;
		$this->SetXY($x, $y);
		$this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'C', 'C');
		$this->Image(dirname(__FILE__).'/logo-ypfb-logistica.png', 16, 12, 36);
		
		$this->SetFontSize(14);
		$this->SetFont('','B');
		$this->Cell(105, $height, 'FICHA TECNICA', 1, 0, 'C', false, '', 0, false, 'M', 'M');
		$x = $this->GetX();
		$y = $this->GetY();
		
		$this->SetFont('','');
		$this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'C', 'C');
		
		
		$this->SetFontSize(7);
		$y-= 7.5;
		$width1 = 17;
		$width2 = 23;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Codigo:', "B", 0, '', false, '', 0, false, 'C', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, $this->dataSource->getParameter('codigo'), "B", 0, 'C', false, '', 0, false, 'C', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Revision:', "B", 0, '', false, '', 0, false, 'C', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, '***', "B", 0, 'C', false, '', 0, false, 'C', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Fecha Emision:', "B", 0, '', false, '', 0, false, 'C', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, $this->dataSource->getParameter('fechaEmision'), "B", 0, 'C', false, '', 0, false, 'C', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Página:', "B", 0, '', false, '', 0, false, 'C', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, $this->PageNo().' de '.$this->getNumPages(), "B", 0, 'C', false, '', 0, false, 'C', 'C');
		
	}
	
	public function Footer() {
		//TODO: implement the footer manager
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
		
		//set margins
		$pdf->SetMargins(PDF_MARGIN_LEFT, 40, PDF_MARGIN_RIGHT);
		
		// add a page
		$pdf->AddPage();
		
		$height = 5;
		$width1 = 30;
		$width2 = 90;
		$pdf->SetFontSize(8);
		$pdf->SetFont('', 'B');
		$pdf->Cell(0, $height, 'INFORMACIÓN DE ESTACIÓN:', 0, 0, 'L', false, '', 0, false, 'M', 'M');
		$pdf->Ln();
		
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Propietario:', 0, 0, 'L', false, '', 0, false, 'M', 'M');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, 'YPFB LOGISTICA SA', 'B', 0, 'L', false, '', 0, false, 'M', 'M');
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Area:', 0, 0, 'L', false, '', 0, false, 'M', 'M');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, '**', 'B', 0, 'L', false, '', 0, false, 'M', 'M');
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Nombre:', 0, 0, 'L', false, '', 0, false, 'M', 'M');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, $this->getDataSource()->getParameter('nombre'), 'B', 0, 'L', false, '', 0, false, 'M', 'M');
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Localización:', 0, 0, 'L', false, '', 0, false, 'M', 'M');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, $this->getDataSource()->getParameter('localizacion'), 'B', 0, 'L', false, '', 0, false, 'M', 'M');
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Punto:', 0, 0, 'L', false, '', 0, false, 'M', 'M');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, '**', 'B', 0, 'L', false, '', 0, false, 'M', 'M');
		
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Funcion:', 0, 0, 'L', false, '', 0, false, 'M', 'M');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, '**', 'B', 0, 'L', false, '', 0, false, 'M', 'M');
		
		//paint el detalle del padre
		
		$dataset = $this->getDataSource()->getDataset();
		$pdf->Ln();
		$pdf->Ln();
		//Detalle de la unidad constructiva
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		$pdf->Cell(0, $height, 'IDENTIFICACIÓN:', 0, 0, 'L', false, '', 0, false, 'M', 'M');
		$pdf->Ln();
		// end title
		//counter 
		$colCount = 0; 
		$pdf->SetFontSize(6.5);
		foreach($dataset as $row) {
			
			//Tabla
			$widthColVariable = 30;
			$widthColValor = 50;
			$widthSeparator = 15;
			if($colCount == 0) {
				$pdf->Cell(10, $height, '', 0, 0, 'C', false, '', 0, false, 'M', 'M');
				$this->writePair($pdf, $row['nombre'], $widthColVariable, $row['valor'], $widthColValor, 0, $height);
				$pdf->Cell($widthSeparator, $height, '', 0, 0, 'C', false, '', 0, false, 'M', 'M');
				$colCount++;
			} else {
				$this->writePair($pdf, $row['nombre'], $widthColVariable, $row['valor'], $widthColValor, 0, $height);
				$pdf->Ln();	
				$colCount = 0;			
			}
		}
		
		//pintamos los hijos.
		
		foreach($this->getDataSource()->getParameter('arrayHijos') as $hijoDataSource) {
			$this->writeHijoUniCons($hijoDataSource, $pdf);
		}
		
		// $pdf->Ln();
		// $pdf->setTextColor(51,51,153);
		// $pdf->setTextColor(51,51,153);
		// $pdf->SetFont('', 'B');
		// $pdf->Cell(0, $height, 'REPUESTOS:', 1, 0, 'L', false, '', 0, false, 'M', 'M');
		// $pdf->Ln();
		
		// $pdf->Ln();
		// $pdf->Ln();
		// foreach($this->getDataSource()->getParam('dataSourceHijos') as $hijoDataSource) {
			// $this->writeHijoUniCons($hijoDataSource, $pdf);
		// }
		
		// $pdf->SetFont('', '');
		// $pdf->setTextColor(0,0,0);
		// $pdf->Cell($width3, $height, 'TAG:', 1, 0, 'L', false, '', 0, false, 'M', 'M');
// 		
		// $pdf->SetFont('', 'B');
		// $pdf->setTextColor(51,51,153);
		// $pdf->Cell($width4, $height, 'PLATAFORMA DE BOMBEO', 1, 0, 'C', false, '', 0, false, 'M', 'M');
// 		
// 		
		
		//Close and output PDF document
		$pdf->Output($fileName, 'F');
	}

	function writePair(TCPDF $pdf, $value1, $widthVal1, $value2, $widthVal2, $pairSeparatorWidth, $height) {
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($widthVal1, $height, $value1, 0, 0, 'L', false, '', 0, false, 'M', 'M');
		if($pairSeparatorWidth > 0) {
			$pdf->Cell($pairSeparatorWidth, $height, '', 0, 0, 'C', false, '', 0, false, 'M', 'M');
		}
		
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($widthVal2, $height, $value2, 1, 0, 'C', false, '', 0, false, 'M', 'M');
	}
	
	function writeHijoUniCons(DataSource $dataSource, TCPDF $pdf) {
		$pdf->Ln();
		$pdf->Ln();
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		$height = 5;
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell(0, $height, $dataSource->getParameter('nombreUniConsHijo'), 1, 0, 'C', true, '', 0, false, 'M', 'M');
		$pdf->Ln();
		$pdf->Ln();
		foreach($dataSource->getDataset() as $row) {
			
			//Tabla
			$widthColVariable = 30;
			$widthColValor = 50;
			$widthSeparator = 15;
			$pdf->setTextColor(0,0,0);
			if($colCount == 0) {
				$pdf->Cell(10, $height, '', 0, 0, 'C', false, '', 0, false, 'M', 'M');
				$this->writePair($pdf, $row['nombre'], $widthColVariable, $row['valor'], $widthColValor, 0, $height);
				$pdf->Cell($widthSeparator, $height, '', 0, 0, 'C', false, '', 0, false, 'M', 'M');
				$colCount++;
			} else {
				$this->writePair($pdf, $row['nombre'], $widthColVariable, $row['valor'], $widthColValor, 0, $height);
				$pdf->Ln();	
				$colCount = 0;			
			}
		}
	}
}
?>