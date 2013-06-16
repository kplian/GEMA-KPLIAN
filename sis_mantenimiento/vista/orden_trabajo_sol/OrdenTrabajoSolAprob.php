<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.OrdenTrabajoSolAprob = {
	require:'../../../sis_mantenimiento/vista/orden_trabajo_sol/OrdenTrabajoSol.php',
	requireclase:'Phx.vista.OrdenTrabajoSol',
	title:'Aprobación de Solicitudes Ordenes de Trabajo',
	bedit: true,
	constructor: function(config) {
		Phx.vista.OrdenTrabajoSolAprob.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50,estado: this.estado}});
		this.readOnlyGroup(0, true);
		this.readOnlyGroup(1, true);
		this.readOnlyGroup(2, false);
		this.readOnlyGroup(3, false);
		this.blockGroup(0);
		this.unblockGroup(2);
		this.unblockGroup(3);
		this.getBoton('btn-fin').hide();
	  	this.getBoton('btn-reporte').hide();
	  	this.getBoton('btn-subirFoto').hide();
		
		this.addButton('btnAprobar', {
				text: 'Aprobar',
				iconCls: 'bunlock',
				disabled: true,
				handler: this.onBtnAprobarSolOT,
				tooltip: '<b>Aprobación de la Solicitud</b><br>Aprueba la Solicitud de Orden de Trabajo seleccionada'
			}
		);
		
		this.addButton('btnCancelar', {
				text: 'Rechazar',
				iconCls: 'bcancelfile',
				disabled: true,
				handler: this.onBtnCancelarSolOT,
				tooltip: '<b>Rechazo de la Solicitud</b><br/>Rechaza la Solicitud de Orden de Trabajo seleccionada.'
			}
		);
	},
	preparaMenu:function(n) {
	  	var tb = Phx.vista.OrdenTrabajoSolAprob.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	if(data.estado=='pendiente'){
	  		this.getBoton('btnAprobar').enable();
	  		this.getBoton('btnCancelar').enable();
  		} else{
  			this.getBoton('btnAprobar').disable();
	  		this.getBoton('btnCancelar').disable();
  		}
  		return tb;
	},
	liberaMenu:function() {
		var tb = Phx.vista.OrdenTrabajoSolAprob.superclass.liberaMenu.call(this);
		this.getBoton('btnAprobar').setDisabled(true);
  		this.getBoton('btnCancelar').setDisabled(true);
		return tb;
	},
	onBtnAprobarSolOT: function() {
		var rec = this.sm.getSelected();
		var data = rec.data;
		Ext.Ajax.request({
			url:'../../sis_mantenimiento/control/OrdenTrabajoSol/finalizarOrdenTrabajoSol',
			params: {
				'id_orden_trabajo_sol': data.id_orden_trabajo_sol,
				estado: 'finalizado'
			},
			success:this.successSave,
			failure: this.conexionFailure,
			timeout:this.timeout,
			scope:this
		});
	},
	onBtnCancelarSolOT: function() {
		var rec = this.sm.getSelected();
		var data = rec.data;
		Ext.Ajax.request({
			url:'../../sis_mantenimiento/control/OrdenTrabajoSol/finalizarOrdenTrabajoSol',
			params: {
				'id_orden_trabajo_sol': data.id_orden_trabajo_sol,
				estado: 'no_aprobado'
			},
			success:this.successSave,
			failure: this.conexionFailure,
			timeout:this.timeout,
			scope:this
		});
	},
	estado: 'finalizacion',
	bnew:false,
	bdel:false
 
};
</script>
