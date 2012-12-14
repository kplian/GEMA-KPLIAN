<?php
ini_set('display_errors', 'On');
require_once dirname(__FILE__).'/../../lib/tcpdf/config/lang/eng.php';
require_once(dirname(__FILE__).'/../../lib/tcpdf/tcpdf.php');
require_once(dirname(__FILE__).'/pxpReport/ReportWriter.php');
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
		$this->Cell($width2, $height/4, /*$this->dataSource->getParameter('codigo')*/ "", "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
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
		$this->Cell($width2, $height/4, /*$this->dataSource->getParameter('fechaEmision')*/"", "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
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

Class ROrdenTrabajo extends Report {

	function write($fileName) {
		$pdf = new CustomReport(PDF_PAGE_ORIENTATION, PDF_UNIT, "LETTER", true, 'UTF-8', false);
		//$pdf->setDataSource($this->getDataSource());
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
		
		$hGlobal = 5;
		$hMedium = 8;
		$wFechaEmision = 15;
		$wSolSector = 20;
		$wPrioridad = 20;
		$wSector = 40;
		$wCuenta = 35;
		$wEquipo = 35;
		$wNoOIT = 20;
		
		$pdf->SetFontSize(7);
		$pdf->SetFont('', 'B');
		$pdf->MultiCell($wFechaEmision, $hMedium, 'FECHA EMISION', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wSolSector, $hMedium, 'SOLICITANTE SECTOR', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wPrioridad, $hMedium, 'PRIORIDAD', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wSector, $hMedium, 'SECTOR', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wCuenta, $hMedium, 'CUENTA', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wEquipo, $hMedium, 'EQUIPO Nº/ PROGRESIVA/TAG', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wNoOIT, $hMedium, 'Nº OIT', 1, 'C', false, 1, '', '', true, 0, false, true, 0, 'M', false);
		
		$pdf->SetFontSize(6.5);
		$pdf->SetFont('', '');
		$pdf->MultiCell($wFechaEmision, $hMedium, '19/12/2012', 1, 'C', false, 0);
		$pdf->MultiCell($wSolSector, $hMedium, 'data SECTOR', 1, 'C', false, 0);
		$pdf->MultiCell($wPrioridad, $hMedium, 'data PRIORIDAD', 1, 'C', false, 0);
		$pdf->MultiCell($wSector, $hMedium, 'data SECTOR', 1, 'C', false, 0);
		$pdf->MultiCell($wCuenta, $hMedium, 'data CUENTA', 1, 'C', false, 0);
		$pdf->MultiCell($wEquipo, $hMedium, 'data EQUIPO Nº/ PROGRESIVA/TAG', 1, 'C', false, 0);
		$pdf->MultiCell($wNoOIT, $hMedium, 'cod19', 1, 'C', false, 1);
		
		$pdf->Cell(20, $hGlobal, 'TIPO DE OIT: ', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Cell(0, $hGlobal, 'data comes here', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Ln();
		
		$pdf->Cell(40, $hGlobal, 'DESCRIPCION EQUIPO/PROGRESIVA: ', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Cell(80, $hGlobal, 'ESPECIALIDAD:', 0, 0, 'R', false, '', 0, false, 'T', 'C');
		$pdf->Cell(0, $hGlobal, 'data comes here', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Ln();
		
		$pdf->MultiCell(30, $hMedium, 'OBSERVACIÓN Y/O FALLA:', 1, 'C', false, 0);
		$pdf->MultiCell(0, $hMedium, 'here comes the larga data, here comes the larga data, here comes the larga data, here comes the larga data, ', 1, 'L', false, 1);
		
		$pdf->Cell(0, $hGlobal, 'DESCRIPCION DETALLADA DEL SERVICIO Y/O REPARACIÓN A REALIZAR', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Ln();
		$pdf->MultiCell(0, $hMedium, 'here comes the larga data, here comes the larga data, here comes the larga data, here comes the larga data, ', 1, 'L', false, 1);
		
		$pdf->Ln();
		$wDescProceso = 85;
		$wCargo = 25;
		$wUnidad = 25;
		$wEstimadas = 25;
		$wReales = 25;
		$pdf->MultiCell($wDescProceso, $hMedium, 'DESCRIPCION DEL PROCESO', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wCargo, $hMedium, 'CARGO', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wUnidad, $hMedium, 'UNIDAD (HR - MIN)', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wEstimadas, $hMedium, 'ESTIMADAS', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wReales, $hMedium, 'REALES', 1, 'C', false, 1, '', '', true, 0, false, true, 0, 'M', false);
		
		//loop to fill all activities
		$pdf->MultiCell($wDescProceso, $hMedium, 'data goes here', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wCargo, $hMedium, 'datea', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wUnidad, $hMedium, 'datea', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wEstimadas, $hMedium, 'data', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wReales, $hMedium, 'data', 1, 'C', false, 1, '', '', true, 0, false, true, 0, 'M', false);
		
		//activities totals
		$pdf->Ln();
		$pdf->Cell(35, $hGlobal, 'Días de Trabajo aproximado: ', 1, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Cell(15, $hGlobal, 'data', 1, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Cell(20, $hGlobal, 'Días Reales', 1, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Cell(15, $hGlobal, 'data', 1, 0, 'L', false, '', 0, false, 'T', 'C');
		$pdf->Cell($wCargo, $hGlobal, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
		$pdf->Cell($wUnidad, $hGlobal, 'TOTAL (HR)', 1, 0, 'C', false, '', 0, false, 'T', 'C');
		$pdf->Cell($wEstimadas, $hGlobal, 'data goes here', 1, 0, 'C', false, '', 0, false, 'T', 'C');
		$pdf->Cell($wReales, $hGlobal, 'data goes here', 1, 0, 'C', false, '', 0, false, 'T', 'C');
		
		$pdf->Ln();
		$pdf->Ln();
		
		$wPedidoCodigo =  25;
		$wExistencias = 20;
		$wMateriales = 30;
		$wUnidad = 15;
		$wPrecio = 20;
		$wCantPlanif = 25;
		$wCantUtiliz = 20;
		$wObservaciones = 30;
		$pdf->MultiCell($wPedidoCodigo, $hMedium, 'PEDIDO O CODIGO', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wExistencias, $hMedium, 'EXISTENCIAS', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wMateriales, $hMedium, 'MATERIALES/ REPUESTOS', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wUnidad, $hMedium, 'UNIDAD', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wPrecio, $hMedium, 'PRECIO', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wCantPlanif, $hMedium, 'CANT. PLANIF.', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wCantUtiliz, $hMedium, 'CANT. UTILIZ.', 1, 'C', false, 0, '', '', true, 0, false, true, 0, 'M', false);
		$pdf->MultiCell($wObservaciones, $hMedium, 'OBSERVACIONES', 1, 'C', false, 1, '', '', true, 0, false, true, 0, 'M', false);
		
		// $pdf->SetFontSize(7.5);
		// $pdf->SetFont('', '');
		// $pdf->setTextColor(0,0,0);
		// $pdf->Cell($width1, $height, 'Propietario:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		// $pdf->SetFont('', 'B');
		// $pdf->setTextColor(51,51,153);
		// $pdf->Cell($width2, $height, 'YPFB LOGISTICA SA', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
		// $xPictureBox = $pdf->GetX();
		// $yPictureBox = $pdf->GetY();
		// $pdf->Ln();
		// $pdf->SetFont('', '');
		// $pdf->setTextColor(0,0,0);
		// $pdf->Cell($width1, $height, 'Area:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		// $pdf->SetFont('', 'B');
		// $pdf->setTextColor(51,51,153);
		// $pdf->Cell($width2, $height, '**', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
// 		
		// $pdf->Ln();
		// $pdf->SetFont('', '');
		// $pdf->setTextColor(0,0,0);
		// $pdf->Cell($width1, $height, 'Nombre:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		// $pdf->SetFont('', 'B');
		// $pdf->setTextColor(51,51,153);
		// $pdf->Cell($width2, $height, $this->getDataSource()->getParameter('nombre'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');
// 		
		// $pdf->Ln();
		// $pdf->SetFont('', '');
		// $pdf->setTextColor(0,0,0);
		// $pdf->Cell($width1, $height, 'Localización:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		// $pdf->SetFont('', 'B');
		// $pdf->setTextColor(51,51,153);
		// $pdf->Cell($width2, $height, $this->getDataSource()->getParameter('localizacion'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');
// 		
		// $pdf->Ln();
		// $pdf->SetFont('', '');
		// $pdf->setTextColor(0,0,0);
		// $pdf->Cell($width1, $height, 'Punto:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		// $pdf->SetFont('', 'B');
		// $pdf->setTextColor(51,51,153);
		// $pdf->Cell($width2, $height, $this->getDataSource()->getParameter('punto'), 'B', 0, 'L', false, '', 0, false, 'T', 'C');
// 		
		// $pdf->Ln();
		// $pdf->SetFont('', '');
		// $pdf->setTextColor(0,0,0);
		// $pdf->Cell($width1, $height, 'Funcion:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		// $pdf->SetFont('', 'B');
		// $pdf->setTextColor(51,51,153);
		// $pdf->Cell($width2, $height, '**', 'B', 0, 'L', false, '', 0, false, 'T', 'C');
// 		
		// //paint el detalle del padre
		// $dataset = $this->getDataSource()->getDataset();
		// $pdf->Ln();
		// $pdf->Ln();
		// //Detalle de la unidad constructiva
		// $pdf->SetFontSize(7.5);
		// $pdf->SetFont('', 'B');
		// $pdf->Cell(0, $height, 'IDENTIFICACIÓN:', 0, 0, 'L', false, '', 0, false, 'T', 'C');
		// $pdf->Ln();
		// // end title
// 		
		// $colCount = 0;
		// $pdf->SetFontSize(6.5);
		// foreach($dataset as $row) {
// 			
			// //Tabla
			// $widthColVariable = 30;
			// $widthColValor = 50;
			// $widthSeparator = 15;
			// if($colCount == 0) {
				// $pdf->Cell(10, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
				// $this->writePair($pdf, $row['nombre'], $widthColVariable, $row['valor'], $widthColValor, 0, $height);
				// $pdf->Cell($widthSeparator, $height, '', 0, 0, 'C', false, '', 0, false, 'T', 'C');
				// $colCount++;
			// } else {
				// $this->writePair($pdf, $row['nombre'], $widthColVariable, $row['valor'], $widthColValor, 0, $height);
				// $pdf->Ln();	
				// $colCount = 0;			
			// }
		// }
// 		
		// $this->writeRepuestos($this->getDataSource()->getParameter('repuestoDataSource'), $pdf);
// 		
		// foreach($this->getDataSource()->getParameter('arrayHijos') as $hijoDataSource) {
			// $this->writeHijoUniCons($hijoDataSource, $pdf);
		// }
// 		
		// $this->writeProveedores($this->getDataSource()->getParameter('proveedorDataSource'), $pdf);
// 		
		// //write immage
		// //TODO: write image
		// $pdf->SetXY($xPictureBox, $yPictureBox);
		// $pdf->Cell(0, 30, '', 1, 0, 'L', false, '', 0, false, 'T', 'C');
// 		
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
$reporte = new ROrdenTrabajo();
$nombreArchivo = 'OrdenTrabajo.pdf';
$reportWriter = new ReportWriter($reporte, dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo);
$reportWriter->writeReport(ReportWriter::PDF);
?>