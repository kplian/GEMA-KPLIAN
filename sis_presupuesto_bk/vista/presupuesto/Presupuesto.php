<?php
/**
*@package pXP
*@file gen-Presupuesto.php
*@author  Gonzalo Sarmiento Sejas
*@date 26-11-2012 21:35:35
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Presupuesto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Presupuesto.superclass.constructor.call(this,config);
		
		this.addButton('btnReportePresupuesto',{
            text:'Reporte Presupuesto',
            iconCls: 'blist',
            disabled: false,
            handler:this.onBtnReporte,
            tooltip: '<b>Reporte</b><br/>Reporte Presupuesto'
        });
        
        this.addButton('btnGrafica',{
            text:'Grafica',
            iconCls: 'bstatistics',
            disabled: false,
            handler:this.onBtnGrafica,
            tooltip: '<b>Grafica</b><br/>Grafica Presupuesto vs Ejecutado'
        });
        
        
		this.init();
		this.load({params:{start:0, limit:50}})
	},
	
	onBtnReporte:function(){
        Phx.CP.loadWindows('../../../sis_presupuestos/vista/presupuesto/GeneraReportePresupuesto.php',
            'Genera Reporte Presupuesto',
            {
                modal:true,
                width:600,
                height:300
            },'',this.idContenedor,'GeneraReportePresupuesto')      
    },
    
    onBtnGrafica:function(){
        var rec = this.sm.getSelected();
        if(rec){
            Phx.CP.loadWindows('../../../sis_presupuestos/vista/presupuesto/gridPresupuesto.php',
                    'Presupuestado y ejecutado',
                    {
                        width:800,
                        height:400
                    },rec.data,this.idContenedor,'gridPresupuesto')
    
       }
    },
    	
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
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'pre.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
		},
		{
            config:{
                name: 'codigo',
                fieldLabel: 'Codigo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:20
            },
            type:'TextField',
            filters:{pfiltro:'pre.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'pre.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:15
			},
			type:'TextField',
			filters:{pfiltro:'pre.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'gestion',
				fieldLabel: 'Gestion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'pre.gestion',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
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
			filters:{pfiltro:'pre.fecha_reg',type:'date'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'pre.fecha_mod',type:'date'},
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
		}
	],
	title:'Presupuestos',
	ActSave:'../../sis_presupuestos/control/Presupuesto/insertarPresupuesto',
	ActDel:'../../sis_presupuestos/control/Presupuesto/eliminarPresupuesto',
	ActList:'../../sis_presupuestos/control/Presupuesto/listarPresupuesto',
	id_store:'id_presupuesto',
	fields: [
		{name:'id_presupuesto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'gestion', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_presupuesto',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	tabsouth:[
        {
          url:'../../../sis_presupuestos/vista/presup_partida/PresupPartida.php',
          title:'Presupuestados', 
          height:'50%',
          cls:'PresupPartida',
          params:{tipo:'presupuestado'}
         },
    
         {
          url:'../../../sis_presupuestos/vista/presup_partida/PresupPartida.php',
          title:'Ejecutados', 
          //width:'50%',
          height:'50%',
          cls:'PresupPartida',
          params:{tipo:'ejecutado'}
         }]
	}
)
</script>
		
		