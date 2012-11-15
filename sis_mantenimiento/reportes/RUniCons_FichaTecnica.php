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
		$this->Cell(105, $height, 'FICHA TECNICA', 1, 0, 'C', false, '', 0, false, 'T', 'C');
		$x = $this->GetX();
		$y = $this->GetY();
		
		$this->SetFont('','');
		$this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
		
		
		$this->SetFontSize(7);
		
		$width1 = 17;
		$width2 = 23;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Codigo:', "B", 0, '', false, '', 0, false, 'T', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, $this->dataSource->getParameter('codigo'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Revision:', "B", 0, '', false, '', 0, false, 'T', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, '***', "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Fecha Emision:', "B", 0, '', false, '', 0, false, 'T', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, $this->dataSource->getParameter('fechaEmision'), "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Página:', "B", 0, '', false, '', 0, false, 'T', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, $this->PageNo().' de '.$this->getNumPages(), "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
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
		// $pdf->setLanguageArray($l);
		
		// add a page
		$pdf->AddPage();
		
		$height = 5;
		$width1 = 30;
		$width2 = 90;
		$pdf->SetFontSize(8);
		$pdf->SetFont('', 'B');
		$pdf->Cell(0, $height, 'INFORMACIÓN DE ESTACIÓN:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Ln();
		
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Propietario:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, 'YPFB LOGISTICA SA', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
		$xPictureBox = $pdf->GetX();
		$yPictureBox = $pdf->GetY();
		$pdf->Ln();
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($width1, $height, 'Area:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, '**', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
		
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
		$pdf->Cell($width1, $height, 'Funcion:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->SetFont('', 'B');
		$pdf->setTextColor(51,51,153);
		$pdf->Cell($width2, $height, '**', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
		
		//paint el detalle del padre
		$dataset = $this->getDataSource()->getDataset();
		$pdf->Ln();
		$pdf->Ln();
		//Detalle de la unidad constructiva
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		$pdf->Cell(0, $height, 'IDENTIFICACIÓN:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
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
		
		$this->writeRepuestos($this->getDataSource()->getParameter('repuestoDataSource'), $pdf);
		
		foreach($this->getDataSource()->getParameter('arrayHijos') as $hijoDataSource) {
			$this->writeHijoUniCons($hijoDataSource, $pdf);
		}
		
		$this->writeProveedores($this->getDataSource()->getParameter('proveedorDataSource'), $pdf);
		
		//write immage
		//TODO: write image
		$pdf->SetXY($xPictureBox, $yPictureBox);
		$pdf->Cell(0, 30, '', 1, 0, 'L', false, '', 0, false, 'T', 'C');
		
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
	
	function writeHijoUniCons(DataSource $dataSource, TCPDF $pdf) {
		$pdf->Ln();
		$pdf->Ln();
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		$height = 5;
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell(0, $height, $dataSource->getParameter('nombreUniConsHijo'), 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		$pdf->Ln();
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
	
	function writeRepuestos (DataSource $dataSource, TCPDF $pdf) {
		$widthMarginLeft = 10;
		$widthNombre = 60;
		$widthItem = 20;
		$widthObservaciones = 90;
		
		$pdf->Ln();
		$pdf->Ln();
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		$height = 5;
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		$pdf->Cell($widthNombre + $widthItem + $widthObservaciones, $height, 'Repuestos', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		
		$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		$pdf->Cell($widthNombre, $height, 'Nombre', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthItem, $height, 'Nº Item', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthObservaciones, $height, 'Observaciones', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		$pdf->setTextColor(0,0,0);
		$pdf->SetFontSize(6.5);
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
		$pdf->Ln();
		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', 'B');
		$height = 5;
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		if($widthMarginLeft > 0) {
			$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		}
		$pdf->Cell($totalWidth, $height, 'Proveedor de Repuestos', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		
		$pdf->SetFontSize(6);
		if ($widthMarginLeft > 0) {
			$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
		}
		$pdf->Cell($widthDescripcion, $height, 'Descripción', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthParte, $height, 'NºParte/cod.', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthProveedor, $height, 'Proveedor', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthContacto, $height, 'Contacto', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthDireccion, $height, 'Dirección', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthTelefono, $height, 'Telefono', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell($widthEmail, $height, 'Email', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Ln();
		$pdf->setTextColor(0,0,0);
		
		foreach($dataSource->getDataset() as $row) {
			if ($widthMarginLeft > 0) {
				$pdf->Cell($widthMarginLeft, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
			}
			$pdf->Cell($widthDescripcion, $height, $row['desc_proveedor'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthParte, $height, $row['parte'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthProveedor, $height, $row['institucion'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthContacto, $height, $row['contacto'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthDireccion, $height, $row['direccion'], 1, 0, 'L', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthTelefono, $height, $row['telefono'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
			$pdf->Cell($widthEmail, $height, $row['email'], 1, 0, 'C', false, '', 0, false, 'T', 'C');
			$pdf->Ln();
		}
	}
}
?>