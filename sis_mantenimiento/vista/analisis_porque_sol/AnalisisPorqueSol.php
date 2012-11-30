<?php
/**
*@package   pXP
*@file      AnalisisPorqueSol.php
*@author    Gonzalo Sarmiento Sejas
*@date 28-11-2012 22:28:33
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AnalisisPorqueSol=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.AnalisisPorqueSol.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_analisis_porque_sol'
			},
			type:'Field',
			form:true 
		},
		{
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
                name:'id_funcionario',
                fieldLabel:'Funcionario',
                allowBlank:true,
                emptyText:'Funcionario...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_organigrama/control/Funcionario/listarFuncionario',
                    id: 'id_funcionario',
                    root: 'datos',
                    sortInfo:{
                        field: 'id_funcionario',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_funcionario','desc_person'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'desc_person'}
                }),
                valueField: 'id_funcionario',
                displayField: 'desc_person',
                gdisplayField: 'desc_person',
                hiddenName: 'id_funcionario',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                minChars:2,            
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario1']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'desc_funcionario1',
                type:'string'
            },
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
                maxLength:2000
            },
            type:'TextField',
            filters:{pfiltro:'porsol.descripcion',type:'string'},
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
                format:'Y-m-d'
            },
            type:'DateField',
            filters:{pfiltro:'porsol.fecha',type:'date'},
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
            filters:{pfiltro:'porsol.estado',type:'string'},
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
			filters:{pfiltro:'porsol.estado_reg',type:'string'},
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
			filters:{pfiltro:'porsol.fecha_reg',type:'date'},
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
			filters:{pfiltro:'porsol.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Solucion',
	ActSave:'../../sis_mantenimiento/control/AnalisisPorqueSol/insertarAnalisisPorqueSol',
	ActDel:'../../sis_mantenimiento/control/AnalisisPorqueSol/eliminarAnalisisPorqueSol',
	ActList:'../../sis_mantenimiento/control/AnalisisPorqueSol/listarAnalisisPorqueSol',
	id_store:'id_analisis_porque_sol',
	fields: [
		{name:'id_analisis_porque_sol', type: 'numeric'},
		{name:'id_analisis_porque', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'desc_funcionario1', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'fecha', type: 'timestamp'},
		{name:'descripcion', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_analisis_porque_sol',
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
		
		