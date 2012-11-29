<?php
/**
*@package pXP
*@file    AnalisisPorqueDet.php
*@author  Gonzalo Sarmiento Sejas
*@date 28-11-2012 22:01:17
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AnalisisPorqueDet=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.AnalisisPorqueDet.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_analisis_porque_det'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
			    labelSeparator:'',
				name: 'id_analisis_porque',
				inputType:'hidden'				
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'porque',
				fieldLabel: 'Porque',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2000
			},
			type:'TextField',
			filters:{pfiltro:'det.porque',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'respuesta',
				fieldLabel: 'Respuesta',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:3000
			},
			type:'TextField',
			filters:{pfiltro:'det.respuesta',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},		
        {
            config:{
                name: 'solucion',
                fieldLabel: 'Solucion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:3000
            },
            type:'TextField',
            filters:{pfiltro:'det.solucion',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'estado_reg',
                fieldLabel: 'Estado Reg.',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'TextField',
            filters:{pfiltro:'det.estado_reg',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'det.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'det.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Detalle',
	ActSave:'../../sis_mantenimiento/control/AnalisisPorqueDet/insertarAnalisisPorqueDet',
	ActDel:'../../sis_mantenimiento/control/AnalisisPorqueDet/eliminarAnalisisPorqueDet',
	ActList:'../../sis_mantenimiento/control/AnalisisPorqueDet/listarAnalisisPorqueDet',
	id_store:'id_analisis_porque_det',
	fields: [
		{name:'id_analisis_porque_det', type: 'numeric'},
		{name:'id_analisis_porque', type: 'numeric'},
		{name:'solucion', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'porque', type: 'string'},
		{name:'respuesta', type: 'string'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_analisis_porque_det',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	onReloadPage:function(m){       
        this.maestro=m;
        this.Atributos[1].valorInicial=this.maestro.id_analisis_porque;
        if(m.id != 'id'){
        this.store.baseParams={id_analisis_porque:this.maestro.id_analisis_porque};
        this.load({params:{start:0, limit:50}})       
       }
       else{
         this.grid.getTopToolbar().disable();
         this.grid.getBottomToolbar().disable(); 
         this.store.removeAll();            
       }
    } 
}
)
</script>
		
		