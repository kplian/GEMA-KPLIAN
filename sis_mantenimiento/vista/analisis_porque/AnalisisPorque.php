<?php
/**
*@package   pXP
*@file      AnalisisPorque.php
*@author    Gonzalo Sarmiento Sejas
*@date      28-11-2012 20:22:29
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AnalisisPorque=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.AnalisisPorque.superclass.constructor.call(this,config);
		
		this.addButton('btnReporte',{
            text:'Reporte',
            iconCls: 'blist',
            disabled: false,
            handler:function(){
                var rec=this.sm.getSelected();
                console.debug(rec);
                Ext.Ajax.request({
                    url:'../../sis_mantenimiento/control/AnalisisPorque/planillaAnalisisPorque',
                    params:{'id_analisis_porque':rec.data.id_analisis_porque},
                    success: this.successExport,
                    failure: function() {
                        console.log("fail");
                    },
                    timeout: function() {
                        console.log("timeout");
                    },
                    scope:this
                });
            },
            tooltip: '<b>Reporte</b><br/>Registro de Analisis Porque Porque'
        });
        
		this.init();
		this.load({params:{start:0, limit:50, id_uni_cons:this.id_uni_cons}})
		this.loadValoresIniciales();
	},
	
	loadValoresIniciales:function()
    {        
        Phx.vista.AnalisisPorque.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_uni_cons').setValue(this.id_uni_cons);     
    },
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_analisis_porque'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
			    labelSeparator:'',
				name: 'id_uni_cons',
                inputType:'hidden'
			},
			type:'Field',
			form:true
		},		  
        {
            config:{
                name: 'numero',
                fieldLabel: 'Numero de Analisis',
                allowBlank: true,
                anchor: '80%',
                gwidth: 150,
                maxLength:4
            },
            type:'NumberField',
            filters:{pfiltro:'anapor.numero',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
            config:{
                name: 'problema',
                fieldLabel: 'Problema',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:2000
            },
            type:'TextField',
            filters:{pfiltro:'anapor.problema',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'fecha',
                fieldLabel: 'Fecha',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                renderer:function (value,p,record){return value?value.dateFormat('Y-m-d H:i:s'):''},
                format:'Y-m-d H:i:s'
            },
            type:'DateField',
            filters:{pfiltro:'anapor.fecha',type:'date'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config: {
                name: 'estado',
                fieldLabel: 'Estado',
                anchor: '90%',
                tinit: true,
                allowBlank: false,
                origen: 'CATALOGO',
                gdisplayField: 'estado',
                gwidth: 80,
                baseParams:{
                        cod_subsistema:'GEM',
                        catalogo_tipo:'tanalisis_porque_cat_estado_analisis_porque'
                    }
            },
            type: 'ComboRec',
            id_grupo: 0,
            filters:{pfiltro:'anapor.estado',type:'string'},
            grid: true,
            form: true
        },           
        {
            config:{
                name: 'operadores',
                fieldLabel: 'Operadores',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:1000
            },
            type:'TextArea',
            filters:{pfiltro:'anapor.operadores',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'tecnicos',
				fieldLabel: 'Tecnicos',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'anapor.tecnicos',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},		
        {
            config:{
                name: 'coordinadores',
                fieldLabel: 'Coordinadores',
                allowBlank: true,
                anchor: '80%',
                gwidth: 140,
                maxLength:1000
            },
            type:'TextArea',
            filters:{pfiltro:'anapor.coordinadores',type:'string'},
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
			filters:{pfiltro:'anapor.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'anapor.fecha_reg',type:'date'},
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
			filters:{pfiltro:'anapor.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Analisis Porque',
	ActSave:'../../sis_mantenimiento/control/AnalisisPorque/insertarAnalisisPorque',
	ActDel:'../../sis_mantenimiento/control/AnalisisPorque/eliminarAnalisisPorque',
	ActList:'../../sis_mantenimiento/control/AnalisisPorque/listarAnalisisPorque',
	id_store:'id_analisis_porque',
	fields: [
		{name:'id_analisis_porque', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'tecnicos', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'fecha', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'operadores', type: 'string'},
		{name:'coordinadores', type: 'string'},
		{name:'problema', type: 'string'},
		{name:'numero', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_analisis_porque',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
    tabsouth:[
        {
          url:'../../../sis_mantenimiento/vista/analisis_porque_det/AnalisisPorqueDet.php',
          title:'Detalle', 
          height:'50%',
          cls:'AnalisisPorqueDet'
         },    
         {
          url:'../../../sis_mantenimiento/vista/analisis_porque_sol/AnalisisPorqueSol.php',
          title:'Solucion', 
          //width:'50%',
          height:'50%',
          cls:'AnalisisPorqueSol'
    }]
}
)
</script>
		
		