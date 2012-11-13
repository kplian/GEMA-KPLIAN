<?php
/**
*@package       pXP
*@file          gen-PlanMant.php
*@author        (rac)
*@date          12-10-2012 16:15:31
*@description   Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PlanMant=Ext.extend(Phx.gridInterfaz,{
    
	constructor:function(config){
		this.maestro=config.maestro;
		Phx.vista.PlanMant.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, id_uni_cons:this.id_uni_cons}});
	},
				
	Atributos:[
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_plan_mant'
			},
			type:'Field',
			form:true,
			valorInicial: this.id_plan_mant 
		},
		{
			config:{
				name: 'id_funcionario',
				fieldLabel: 'Funcionario',
				allowBlank: false,
				emptyText:'Funcionario...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/Funcionario/listarFuncionario',
					id: 'id_funcionario',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_funcionario','desc_person'],
					remoteSort: true,
					baseParams:{par_filtro:'desc_person'}
				}),
				valueField: 'id_funcionario',
   				displayField: 'desc_person',
   				gdisplayField:'nombre',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{desc_person}</p> </div></tpl>',
   				hiddenName: 'id_funcionario',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:100,
   				minChars:2,   				
   				renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}								
			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{	
		        pfiltro:'nombre',
				type:'string'
	        },   		   
   			grid:false,
   			form:true
		},
		{
			config:{
				name: 'nombre_funcionario',
				fieldLabel: 'Funcionario',
				anchor: '80%',
				gwidth: 100
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'id_funcionario_rev',
				fieldLabel: 'Funcionario rev',
				allowBlank: false,
				emptyText:'Funcionario rev...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/Funcionario/listarFuncionario',
					id: 'id_funcionario',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_funcionario','desc_person'],
					remoteSort: true,
					baseParams:{par_filtro:'desc_person'}
				}),
				valueField: 'id_funcionario',
   				displayField: 'desc_person',
   				gdisplayField:'nombre',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{desc_person}</p> </div></tpl>',
   				hiddenName: 'id_funcionario',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:100,
   				minChars:2,   				
   				renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}
			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{	
		        pfiltro:'nombre',
				type:'string'
	        },   		   
   			grid:false,
   			form:true
		},
		{
			config:{
				name: 'nombre_funcionario_rev',
				fieldLabel: 'Funcionario revisor',
				anchor: '80%',
				gwidth: 100
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'id_tipo_mant',
				fieldLabel: 'Tipo de mantenimiento',
				allowBlank: false,
				emptyText:'Tipo de mantenimiento...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/TipoMant/listarTipoMant',
					id: 'id_tipo_mant',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_mant','nombre'],
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_tipo_mant',
   				displayField: 'nombre',
   				gdisplayField:'nombre',
   				hiddenName: 'id_tipo_mant',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:100,
   				minChars:2,   				   			   
   				renderer:function (value, p, record){return String.format('{0}', record.data['nombre']);}
			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{	
		        pfiltro:'nombre',
				type:'string'
            },   		   
   			grid:false,
   			form:true
		},
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_uni_cons'								
			},
			type:'Field',			
			form:true
		},		
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'plama.descripcion',type:'string'},
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
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y/m/d'
			},
			type:'DateField',
			filters:{pfiltro:'plama.fecha',type:'date'},
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
			filters:{pfiltro:'plama.estado_reg',type:'string'},
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
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'plama.fecha_reg',type:'date'},
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
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'plama.fecha_mod',type:'date'},
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
	title:'Plan de Mantenimiento',
	ActSave:'../../sis_mantenimiento/control/PlanMant/insertarPlanMant',
	ActDel:'../../sis_mantenimiento/control/PlanMant/eliminarPlanMant',
	ActList:'../../sis_mantenimiento/control/PlanMant/listarPlanMant',
	id_store:'id_plan_mant',
	
	onButtonNew: function() {		
		Phx.vista.PlanMant.superclass.onButtonNew.call(this);	
		this.getComponente('id_uni_cons').setValue(this.id_uni_cons);	
	},
	
	fields: [
		{name:'id_plan_mant', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'nombre_funcionario',type:'string'},
		{name:'id_funcionario_rev', type: 'numeric'},		
		{name:'nombre_funcionario_rev',type:'string'},		
		{name:'id_tipo_mant', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'fecha', type: 'timestamp'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}		
	],
	sortInfo:{
		field: 'id_plan_mant',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	south:{
		  url:'../../../sis_mantenimiento/vista/tarea/Tarea.php',
		  title:'Tareas de mantenimiento',
		  height:'40%', 
		  width:400,
		  cls:'Tarea'
	}	
}
)
</script>
		
		