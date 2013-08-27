<?php
/**
*@package pXP
*@file gen-MantPredef.php
*@author  (admin)
*@date 28-08-2012 20:25:32
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PresupuestoNuevo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PresupuestoNuevo.superclass.constructor.call(this,config);
		
		this.definirGrupos();
		
		this.plugingGroup = new Ext.ux.grid.ColumnHeaderGroup({
                 rows: [this.mesesGroups]
        });
		
		
		
		
		
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
	},
	tam_pag: 50,
	mesesGroups: [],
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_presupuesto'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'tot_planif',
				fieldLabel: 'Planif.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'tot_ejec',
				fieldLabel: 'Ejec..',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'tot_porcen',
				fieldLabel: '% Ejec.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'mat_planif',
				fieldLabel: 'Planif.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'mat_ejec',
				fieldLabel: 'Ejec..',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'mat_porcen',
				fieldLabel: '% Ejec.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'ser_planif',
				fieldLabel: 'Planif.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'ser_ejec',
				fieldLabel: 'Ejec..',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		},{
			config:{
				name: 'ser_porcen',
				fieldLabel: '% Ejec.',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'NumberField',
			id_grupo:1,
			grid:true,
			form:true
		}
	],
	title:'Mantenimientos predefinidos',
	ActSave:'../../sis_mantenimiento/control/MantPredef/insertarMantPredef',
	ActDel:'../../sis_mantenimiento/control/MantPredef/eliminarMantPredef',
	ActList:'../../sis_mantenimiento/control/MantPredef/listarMantPredef',
	id_store:'id_mant_predef',
	fields: [
		{name:'id_mant_predef', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'id_tipo_equipo', type: 'numeric'},
		{name:'desc_tipo_equipo', type: 'string'},
		{name:'id_unidad_medida_estimado', type: 'numeric'},
		{name:'tiempo_estimado', type: 'numeric'},
		{name:'desc_unidad_medida_estimado', type: 'string'},
		{name:'id_tipo_mant', type: 'numeric'},
		{name:'desc_tipo_mant', type: 'string'}
	],
	south:{
		  url:'../../../sis_mantenimiento/vista/mant_predef_det/MantPredefDet.php',
		  title:'Detalle actividades', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'MantPredefDet'
	},	
	sortInfo:{
		field: 'id_mant_predef',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fwidth: 450,
	fheight: 300,
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	definirGrupos: function(){
		this.mesesGroups.push({
                    header: 'Total',
                    colspan:3,
                    align: 'center'
        });
        this.mesesGroups.push({
                    header: 'Materiales',
                    colspan:3,
                    align: 'center'
        });
        this.mesesGroups.push({
                    header: 'Servicios',
                    colspan:3,
                    align: 'center'
        });
	}
})
</script>
		
		