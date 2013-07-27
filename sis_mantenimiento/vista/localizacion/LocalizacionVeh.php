<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  rcm
*@date 19/05/2013
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.LocalizacionVeh = {
	require:'../../../sis_mantenimiento/vista/localizacion/Localizacion.php',
	requireclase:'Phx.vista.Localizacion',
	title:'Localización - Vehículos',
	bdel: true,
	bedit: true,
	bnew: true,
	constructor: function(config) {
       	Phx.vista.LocalizacionVeh.superclass.constructor.call(this,config);
		this.init();
   		
	},
    vista:'vehiculos'
};
</script>
