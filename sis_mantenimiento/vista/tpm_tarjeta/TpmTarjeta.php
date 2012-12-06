<?php
/**
*@package   pXP
*@file      TpmTarjeta.php
*@author    Gonzalo Sarmiento Sejas
*@date 29-11-2012 02:21:39
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TpmTarjeta=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TpmTarjeta.superclass.constructor.call(this,config);
		
		this.addButton('btnReporte',{
            text:'Reporte',
            iconCls: 'blist',
            disabled: false,
            handler:function(){
                var rec=this.sm.getSelected();
                console.debug(rec);
                Ext.Ajax.request({
                    url:'../../sis_mantenimiento/control/TpmTarjeta/planillaTpmTarjeta',
                    params:{'id_tpm_tarjeta':rec.data.id_tpm_tarjeta},
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
            tooltip: '<b>Reporte</b><br/>Planilla de control tarjeta TPM'
        });
        
		this.init();
        this.load({params:{start:0, limit:50, id_localizacion:this.id_localizacion}})
        this.loadValoresIniciales();
	},
	
	loadValoresIniciales:function()
    {        
        Phx.vista.TpmTarjeta.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_localizacion').setValue(this.id_localizacion);     
    },
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tpm_tarjeta'
			},
			type:'Field',
			form:true 
		},		
        {
            config:{
                labelSeparator :'',
                name: 'id_localizacion',
                inputType: 'hidden'                
            },
            type:'Field',
            form:true
        },
		{
            config:{
                name: 'codigo',
                fieldLabel: 'Codigo',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:15
            },
            type:'TextField',
            filters:{pfiltro:'tartpm.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'revision',
                fieldLabel: 'Revision',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:4
            },
            type:'NumberField',
            filters:{pfiltro:'tartpm.revision',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'fecha_emision',
                fieldLabel: 'Fecha emision',
                allowBlank: true,
                anchor: '80%',
                gwidth: 120,
                renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                format:'d/m/Y'
            },
            type:'DateField',
            filters:{pfiltro:'tartpm.fecha_emision',type:'date'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config: {
                name: 'tipo',
                fieldLabel: 'Tipo',
                anchor: '90%',
                tinit: true,
                allowBlank: false,
                origen: 'CATALOGO',
                gdisplayField: 'descripcion',
                gwidth: 80,
                baseParams:{
                        cod_subsistema:'GEM',
                        catalogo_tipo:'ttpm_tarjeta_cat_tipo_instalacion'
                    }
            },
            type: 'ComboRec',
            id_grupo: 0,
            filters:{pfiltro:'tartpm.tipo',type:'string'},
            grid: true,
            form: true
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
			filters:{pfiltro:'tartpm.estado_reg',type:'string'},
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
			filters:{pfiltro:'tartpm.fecha_reg',type:'date'},
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
			filters:{pfiltro:'tartpm.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Control de Tarjetas TPM',
	ActSave:'../../sis_mantenimiento/control/TpmTarjeta/insertarTpmTarjeta',
	ActDel:'../../sis_mantenimiento/control/TpmTarjeta/eliminarTpmTarjeta',
	ActList:'../../sis_mantenimiento/control/TpmTarjeta/listarTpmTarjeta',
	id_store:'id_tpm_tarjeta',
	fields: [
		{name:'id_tpm_tarjeta', type: 'numeric'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_emision',type: 'date', dateFormat:'Y-m-d'},
		{name:'tipo', type: 'string'},
		{name:'revision', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_tpm_tarjeta',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	south:{	   
        url:'../../../sis_mantenimiento/vista/tpm_tarjeta_det/TpmTarjetaDet.php',
        title:'Detalles', 
        height : '50%',
        cls:'TpmTarjetaDet'    
    }
}
)
</script>
		
		