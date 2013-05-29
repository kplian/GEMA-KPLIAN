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
		
		$this->SetFontSize(14);
		$this->SetFont('','B');
		$this->Cell(105, $height, 'ORDEN INTERNA DE TRABAJO', 1, 0, 'C', false, '', 0, false, 'T', 'C');
		$x = $this->GetX();
		$y = $this->GetY();
		
		$this->SetFont('','');
		$this->Cell(40, $height, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');
		
		
		$this->SetFontSize(7);
		$width1 = 17;
		$width2 = 23;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Código:', "B", 0, '', false, '', 0, false, 'T', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, 'GMAN-RG-SM-015', "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Revisión:', "B", 0, '', false, '', 0, false, 'T', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, '1', "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Fecha Emision:', "B", 0, '', false, '', 0, false, 'T', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, '29/06/2012', "B", 0, 'C', false, '', 0, false, 'T', 'C');
		
		$this->SetFont('','');
		$y += 5;
		$this->SetXY($x, $y);
		$this->setCellPaddings(2);
		$this->Cell($width1, $height/4, 'Página:', "B", 0, '', false, '', 0, false, 'T', 'C');
		$this->SetFont('','B');
		$this->Cell($width2, $height/4, '                  '.$this->getAliasNumPage().' de '.$this->getAliasNbPages(), "B", 0, 'C', false, '', 0, false, 'T', 'C');
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

	public function MultiRow($pArray,$pWidth,$pAlign,$pTotalFilas,$pFila) {
		// MultiCell($w, $h, $txt, $border=0, $align='J', $fill=0, $ln=1, $x='', $y='', $reseth=true, $stretch=0)
	
		$page_start = $this->getPage();
		$y_start = $this->GetY();
		$i=0;
		$x=$this->getX();
		$y=$this->getY();
		foreach ($pArray as $value) {
			//$this->MultiCell(40, 0, $value, 1, 'R', 1, 2, '', '', true, 0);
			$nb=max($nb,$this->getNumLines($value,$pWidth[$i]));
			$i++;
			
		}
		
		//ALto de las columnas
		$alto=3*$nb;
		$j=0;
		

		foreach ($pArray as $value) {
			if($i>0){
				$this->setXY($x,$y);
			}
			
			//Verificación de borde
			if($pFila==$pTotalFilas){
				if($value==''){
					$borde='LRB';
				} else{
					$borde='LRTB';
				}
			} else{
				if($value==''){
					$borde='LR';
				} else{
					$borde='LRT';
				}
			}
			
			$this->MultiCell($pWidth[$j], $alto, $value, $borde, $pAlign[$j], 0, 2, '', '', true, 0);
			$j++;
			$x=$this->getX();
		}
		$this->Ln(0);
	}
}

Class ROrdenTrabajo extends Report {

	function write($fileName) {
		$pdf = new CustomReport(PDF_PAGE_ORIENTATION, PDF_UNIT, "LETTER", true, 'UTF-8', false);
		$pdf->setDataSource($this->getDataSource());
		$dataSource = $this->getDataSource();
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
		
		$pdf->SetFontSize(6.5);
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,255);
		//$pdf->SetFillColor(0,176,240);
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		$pdf->MultiCell($w = $wFechaEmision, $h = $hMedium, $txt = 'FECHA EMISION', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wSolSector+25, $h = $hMedium, $txt = 'SOLICITANTE', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wPrioridad, $h = $hMedium, $txt = 'PRIORIDAD', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wSector+10, $h = $hMedium, $txt = 'SECTOR', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		//$pdf->MultiCell($w = $wCuenta, $h = $hMedium, $txt = 'CUENTA', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wEquipo, $h = $hMedium, $txt = 'EQUIPO Nº/ PROGRESIVA/TAG', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wNoOIT, $h = $hMedium, $txt = 'Nº OIT', $border = 1, $align = 'C', $fill = true, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		
		$pdf->SetFontSize(6.5);
		$pdf->SetFont('', '');
		$pdf->setTextColor(0,0,0);
		$pdf->MultiCell($w = $wFechaEmision, $h = $hGlobal, $txt = $dataSource->getParameter('fechaEmision'), $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hGlobal, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wSolSector+25, $h = $hGlobal, $txt = $dataSource->getParameter('nombreSolicitante'), $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hGlobal, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wPrioridad, $h = $hGlobal, $txt = $dataSource->getParameter('prioridad'), $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hGlobal, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wSector+10, $h = $hGlobal, $txt = $dataSource->getParameter('sector'), $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hGlobal, $valign = 'M', $fitcell = false); 	
		//$pdf->MultiCell($w = $wCuenta, $h = $hGlobal, $txt = $dataSource->getParameter('centro_costo'), $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hGlobal, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wEquipo, $h = $hGlobal, $txt = $dataSource->getParameter('codigo'), $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hGlobal, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wNoOIT, $h = $hGlobal, $txt = $dataSource->getParameter('nOit'), $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hGlobal, $valign = 'M', $fitcell = false);
		
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 20, $h = $hGlobal, $txt = 'TIPO DE OIT:', $border = 1, $ln = 0, $align = 'L', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0); 	
		$pdf->Cell($w = 60, $h = $hGlobal, $txt = $dataSource->getParameter('tipoOit') . '' . $dataSource->getParameter('tipoMant'), $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 22, $h = $hGlobal, $txt = 'CENTRO COSTO:', $border = 1, $ln = 0, $align = 'L', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0); 	
		$pdf->Cell($w = 28, $h = $hGlobal, $txt = $dataSource->getParameter('centro_costo'), $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 27, $h = $hGlobal, $txt = 'CUENTA CONTABLE:', $border = 1, $ln = 0, $align = 'L', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0); 	
		$pdf->Cell($w = 28, $h = $hGlobal, $txt = $dataSource->getParameter('cuenta'), $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 50, $h = $hGlobal, $txt = 'DESCRIPCIÓN EQUIPO/PROGRESIVA: ', $border = 1, $ln = 0, $align = 'L', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = 135, $h = $hGlobal, $txt = $dataSource->getParameter('descripcion_progresiva'), $border = 1, $ln = 1, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 30, $h = $hGlobal, $txt = 'ESPECIALIDAD:', $border = 1, $ln = 0, $align = 'L', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = 155, $h = $hGlobal, $txt = $dataSource->getParameter('especialidad'), $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		$pdf->Ln();
		
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 185, $h = $hGlobal, $txt = 'DESCRIPCIÓN DE FALLA', $border = 1, $ln = 1, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		//$pdf->MultiCell($w = 185, $h = $hMedium, $txt = $dataSource->getParameter('descripcion'), $border = 1, $align = 'L', $fill = false, $ln = 1, $x = '', $y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
		$pdf->MultiCell($w = 185, 0, $txt = $dataSource->getParameter('descripcion'), $border = 1, $align = 'L', $fill = false, $ln = 1, $x = '', $y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
		
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 185, $h = $hGlobal, $txt = 'DESCRIPCIÓN DETALLADA DEL SERVICIO Y/O REPARACIÓN A REALIZAR', $border = 1, $ln = 1, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		
		$pdf->MultiCell($w = 185, 0, $txt = $dataSource->getParameter('observacion'), $border = 1, $align = 'L', $fill = false, $ln = 1, $x = '', $y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = true);
		$pdf->Ln();
		
		$wDescProceso = 85;
		$wCargo = 25;
		$wUnidad = 25;
		$wEstimadas = 25;
		$wReales = 25;
		
		
		//tabla de actividades
		/*$pdf->setTextColor(0,0,255);
		$pdf->MultiCell($w = $wDescProceso, $h = $hMedium, $txt = 'DESCRIPCION DEL PROCESO', $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wCargo, $h = $hMedium, $txt = 'CARGO', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wUnidad, $h = $hMedium, $txt = 'UNIDAD (HR - MIN)', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wEstimadas, $h = $hMedium, $txt = 'ESTIMADAS', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false); 	
		$pdf->MultiCell($w = $wReales, $h = $hMedium, $txt = 'REALES', $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		
		$pdf->setTextColor(0,0,0);
		foreach($dataSource->getParameter('actividadesDataSource')->getDataset() as $datarow) {
			$pdf->MultiCell($w = $wDescProceso, $h = $hMedium, $txt = $datarow['descripcion'], $border = 1, $align = 'L', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false); 	
			$pdf->MultiCell($w = $wCargo, $h = $hMedium, $txt = 'data', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false); 	
			$pdf->MultiCell($w = $wUnidad, $h = $hMedium, $txt = 'data', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false); 	
			$pdf->MultiCell($w = $wEstimadas, $h = $hMedium, $txt = 'data', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false); 	
			$pdf->MultiCell($w = $wReales, $h = $hMedium, $txt = 'data', $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
		}
		
		$pdf->Cell($w = 35, $h = $hGlobal, $txt = 'Días de Trabajo aproximado: ', $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = 15, $h = $hGlobal, $txt = ($dataSource->getParameter('tiempoEstimado').' '.$dataSource->getParameter('unidadMedidaTiempoEstimado')), $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = 20, $h = $hGlobal, $txt = 'Dias Reales: ', $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = 15, $h = $hGlobal, $txt = $dataSource->getParameter('diasReales'), $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wCargo, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = 'TOTAL (HR)', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wEstimadas, $h = $hGlobal, $txt = 'data goes here', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wReales, $h = $hGlobal, $txt = 'data goes here', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		$pdf->Ln();
*/
		
		//$pdf->SetFillColor(0,176,240);
		$pdf->SetFillColor(51,51,153, true);
		//$pdf->setTextColor(0,0,0);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 185, $h = $hGlobal, $txt = 'DETALLE DE REPUESTOS Y/O MATERIALES', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		
		//REPUESTOS
		$wPedidoCodigo =  25;
		$wExistencias = 20;
		$wMateriales = 45;
		$wUnidad = 15;
		$wPrecio = 20;
		$wCantUtiliz = 25;
		$wObservaciones = 35;
		$counter = 0;
		
		$pdf->setTextColor(255,255,255);
		$pdf->MultiCell($w = $wPedidoCodigo, $h = $hMedium, $txt = 'PEDIDO O CÓDIGO', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wExistencias, $h = $hMedium, $txt = 'EXISTENCIAS', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wMateriales, $h = $hMedium, $txt = 'MATERIALES/ REPUESTOS', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wUnidad, $h = $hMedium, $txt = 'UNIDAD', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wPrecio, $h = $hMedium, $txt = 'PRECIO', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wCantUtiliz, $h = $hMedium, $txt = 'CANT. UTILIZ.', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wObservaciones, $h = $hMedium, $txt = 'OBSERVACIONES', $border = 1, $align = 'C', $fill = true, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		
		$pdf->setTextColor(0,0,0);
		foreach($dataSource->getParameter('repuestosDataSource')->getDataset() as $datarow) {
			$pdf->MultiCell($w = $wPedidoCodigo, $h = $hMedium, $txt = $datarow['codigo'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wExistencias, $h = $hMedium, $txt = $datarow['existencias'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wMateriales, $h = $hMedium, $txt = $datarow['nombre_item'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wUnidad, $h = $hMedium, $txt = $datarow['codigo_unidad_medida'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wPrecio, $h = $hMedium, $txt = $datarow['costo'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wCantUtiliz, $h = $hMedium, $txt = $datarow['cantidad'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wObservaciones, $h = $hMedium, $txt = $datarow['observaciones'], $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$counter++;
		}
		
		for($i = $counter; $i < 10; $i++) {
			$pdf->MultiCell($w = $wPedidoCodigo, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wExistencias, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wMateriales, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wUnidad, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wPrecio, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wCantUtiliz, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wObservaciones, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
		}

		//manage Funcionarios
		if($pdf->getY() > 15) {
			$pdf->AddPage();
		}
		
		$pdf->Ln();
		//$pdf->SetFillColor(0,176,240);
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 185, $h = $hGlobal, $txt = 'DETALLE DE MANO DE OBRA', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		
		$wHHNormal = 15;
		$wHHExtras = 15;
		$wExtMov = 15;
		$wNombre = 40;
		$wCargo = 45;
		$wObservaciones = 40;
		$counter = 0;
		
		$pdf->setTextColor(255,255,255);
		$pdf->MultiCell($w = $wHHNormal, $h = $hMedium, $txt = 'HH NORMAL', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wHHNormal, $h = $hMedium, $txt = 'HH EXTRA', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wHHExtras, $h = $hMedium, $txt = 'HH NOCTURNO', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wExtMov, $h = $hMedium, $txt = 'HH. FER. Y DOM.', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wNombre, $h = $hMedium, $txt = 'NOMBRE', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wCargo, $h = $hMedium, $txt = 'CARGO', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		$pdf->MultiCell($w = $wObservaciones, $h = $hMedium, $txt = 'OBSERVACIONES', $border = 1, $align = 'C', $fill = true, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		
		$pdf->setTextColor(0,0,0);
		foreach($dataSource->getParameter('funcionariosDataSource')->getDataset() as $datarow) {
			$pdf->MultiCell($w = $wHHNormal, $h = $hMedium, $txt = $datarow['hh_normal'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wHHExtras, $h = $hMedium, $txt = $datarow['hh_extras'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wExtMov, $h = $hMedium, $txt = $datarow['hh_ext_mov'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wExtMov, $h = $hMedium, $txt = $datarow['hh_fer_dom'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wNombre, $h = $hMedium, $txt = $datarow['nombre_funcionario'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wCargo, $h = $hMedium, $txt = $datarow['cargo_funcionario'], $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wObservaciones, $h = $hMedium, $txt = $datarow['observaciones'], $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$i++;
		}

		for($i = $counter; $i < 6; $i++) {
			$pdf->MultiCell($w = $wHHNormal, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wHHExtras, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wExtMov, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wExtMov, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wNombre, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wCargo, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
			$pdf->MultiCell($w = $wObservaciones, $h = $hMedium, $txt = '', $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = false);
		}

		//Produjo paro
		$pdf->setTextColor(255,255,255);
		$pdf->Cell(140, $height+5, '¿EL EQUIPO PRODUJO PARO?      SI              NO', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$checkBoxSi;
        $checkBoxNo;
		
		
        if($dataSource->getParameter('ubicacion_tecnica')=='Si'){
            $checkBoxSi='<input type="checkbox" name="boxLugarSi" value="1" checked="checked">';
            $checkBoxNo='<input type="checkbox" name="boxLugarNo" value="1">';    
        }else{
            $checkBoxSi='<input type="checkbox" name="boxLugarSi" value="1">';
            $checkBoxNo='<input type="checkbox" name="boxLugarNo" value="1" checked="checked">';
        }
		$pdf->Cell(20, $height+5, 'HORAS PARO:', 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->Cell(25, $height+5, $dataSource->getParameter('nota_tecnico_loc'), 1, 0, 'C', true, '', 0, false, 'T', 'C');
		$pdf->setTextColor(0,0,0);
		$pdf->writeHTMLCell(5,5,$pdf->getX()-100,$pdf->getY()+1,"$checkBoxSi");        
        $pdf->writeHTMLCell(5,5,$pdf->getX()+ 8,$pdf->getY(),"$checkBoxNo");
		

		//Certificacion de trabajo
		$pdf->Ln();
		$pdf->Ln();
		//$pdf->SetFillColor(0,176,240);
		$pdf->SetFillColor(51,51,153, true);
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 185, $h = $hGlobal, $txt = 'CERTIFICACIÓN DE TRABAJO REALIZADO', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		
		$wHoraServicio = 40;
		$wFecha = 20;
		$wFechaDato = 25;
		$wHora = 15;
		$wHoraDato = 15;
		$wResp = 30;
		$wRespDato = 40;
		
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wHoraServicio - 13, $h = $hGlobal, $txt = 'INICIO DEL SERVICIO', $border = 'LBT', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wFecha - 3, $h = $hGlobal, $txt = 'FECHA: ', $border = 'BRT', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wFechaDato, $h = $hGlobal, $txt = $dataSource->getParameter('fechaEjecIni'), $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wHora-5, $h = $hGlobal, $txt = 'HORA', $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wHoraDato, $h = $hGlobal, $txt = $dataSource->getParameter('horaEjeInicio'), $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		/*$pdf->Cell($w = $wResp, $h = $hGlobal, $txt = 'RESP (OP. pt)', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wRespDato, $h = $hGlobal, $txt = 'data', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');*/
		
		//$pdf->Ln();
		
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wHoraServicio - 15, $h = $hGlobal, $txt = 'FIN DEL SERVICIO', $border = 'LBT', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wFecha - 4, $h = $hGlobal, $txt = 'FECHA: ', $border = 'RBT', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wFechaDato, $h = $hGlobal, $txt = $dataSource->getParameter('fechaEjecFin'), $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wHora-5, $h = $hGlobal, $txt = 'HORA', $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wHoraDato, $h = $hGlobal, $txt = $dataSource->getParameter('horaEjeFin'), $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		/*$pdf->Cell($w = $wResp, $h = $hGlobal, $txt = 'RESP (OP. pt)', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wRespDato, $h = $hGlobal, $txt = 'data', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');*/
		
		$pdf->Ln();
		$pdf->Ln();
		$wBlock = 46;
		
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = $wBlock, $h = $hGlobal, $txt = 'SOLICITADO', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wBlock, $h = $hGlobal, $txt = 'APROBADO', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wBlock, $h = $hGlobal, $txt = 'EJECUTADO', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wBlock + 1, $h = $hGlobal, $txt = 'RECIBIDO', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		
		$pdf->Ln();
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wBlock, $h = $hGlobal, $txt = 'Firma', $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wBlock, $h = $hGlobal, $txt = 'Firma', $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wBlock, $h = $hGlobal, $txt = 'Firma', $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wBlock + 1, $h = $hGlobal, $txt = 'Firma', $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		
		$pdf->SetFontSize(6);
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = ($wBlock-25)/2, $h = $hGlobal, $txt = 'Nombre:', $border = 'LB', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = 35.5, $h = $hGlobal, $txt = $dataSource->getParameter('nombreSolicitante'), $border = 'B', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = ($wBlock-25)/2, $h = $hGlobal, $txt = 'Nombre:', $border = 'LB', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = 35.5, $h = $hGlobal, $txt = $dataSource->getParameter('nombreAprobado'), $border = 'B', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = ($wBlock-25)/2, $h = $hGlobal, $txt = 'Nombre:', $border = 'LB', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = 35.5, $h = $hGlobal, $txt = $dataSource->getParameter('nombreEjecutado'), $border = 'B', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = ($wBlock-25)/2, $h = $hGlobal, $txt = 'Nombre:', $border = 'LB', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = 35.5 + 1, $h = $hGlobal, $txt = $dataSource->getParameter('nombreRecibido'), $border = 'BR', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wBlock/2, $h = $hGlobal, $txt = 'Fecha:', $border = 'LB', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wBlock/2, $h = $hGlobal, $txt = '', $border = 'B', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wBlock/2, $h = $hGlobal, $txt = 'Fecha:', $border = 'LB', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wBlock/2, $h = $hGlobal, $txt = '', $border = 'B', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wBlock/2, $h = $hGlobal, $txt = 'Fecha:', $border = 'LB', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = $wBlock/2, $h = $hGlobal, $txt = '', $border = 'B', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,255);
		$pdf->Cell($w = $wBlock/2, $h = $hGlobal, $txt = 'Fecha:', $border = 'LB', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->setTextColor(0,0,0);
		$pdf->Cell($w = ($wBlock/2) + 1, $h = $hGlobal, $txt = '', $border = 'BR', $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		$pdf->Ln();
		
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = 185, $h = $hGlobal, $txt = 'COMENTARIOS SOBRE EL TRABAJO REALIZADO', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		$pdf->setTextColor(0,0,0);
		$pdf->MultiCell($w = 185, $h = $hMedium, $txt = $dataSource->getParameter('comentarios'), $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = true);
		
		$wTercio = 62;
		$hDouble = 16;
		
		$pdf->setTextColor(255,255,255);
		$pdf->Cell($w = $wTercio, $h = $hGlobal, $txt = 'ACCIDENTES', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wTercio, $h = $hGlobal, $txt = 'RECLAMOS', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wTercio - 1, $h = $hGlobal, $txt = 'OTROS', $border = 1, $ln = 0, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Ln();
		$pdf->setTextColor(0,0,0);
		$pdf->MultiCell($w = $wTercio, $h = $hMedium, $txt = $dataSource->getParameter('accidentes'), $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = true);
		$pdf->MultiCell($w = $wTercio, $h = $hMedium, $txt = $dataSource->getParameter('reclamos'), $border = 1, $align = 'C', $fill = false, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = true);
		$pdf->MultiCell($w = $wTercio - 1, $h = $hMedium, $txt = $dataSource->getParameter('otros'), $border = 1, $align = 'C', $fill = false, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'T', $fitcell = true);
		
		//Mantenimientos predefinidos
		//Titulos
		if(count($dataSource->getParameter('mantPredefDataSource')->getDataset())>0){
			$pdf->AddPage();
			$pdf->setTextColor(255,255,255);
			$pdf->SetFont('','B');
			$pdf->SetFontSize(14);
			$pdf->Cell($w = 185, $h = $hGlobal, $txt = 'DETALLE DEL  MANTENIMIENTO A REALIZAR', $border = 1, $ln = 1, $align = 'C', $fill = true, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			$pdf->setTextColor(255,255,255);
			$pdf->SetFont('','');
			$pdf->SetFontSize(10);
			//$pdf->MultiCell($w = 10, $h = $hMedium, $txt = 'NRO.', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			$pdf->MultiCell($w = 100, $h = $hMedium, $txt = 'DESCRIPCIÓN', $border = 1, $align = 'C', $fill = true, $ln = 0, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
			$pdf->MultiCell($w = 85, $h = $hMedium, $txt = 'OBSERVACIONES', $border = 1, $align = 'C', $fill = true, $ln = 1, $x = '',$y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
		}
		
		//Valores
		$pdf->setTextColor(0,0,0);
		$pdf->SetFontSize(8);
		$anchos=array(100,85);
		$aligns=array('L','L');
		$tot=count($dataSource->getParameter('mantPredefDataSource')->getDataset())-1;
		$fila=0;
		//var_dump($dataSource->getParameter('mantPredefDataSource')->getDataset());exit;
		$data=$dataSource->getParameter('mantPredefDataSource')->getDataset();
		
		foreach($dataSource->getParameter('mantPredefDataSource')->getDataset() as $datarow) {
			$pdf->MultiRow($datarow,$anchos,$aligns,$tot,$fila);
			$fila++;
		}

		$pdf->Output($fileName, 'F');
	}
}
?>