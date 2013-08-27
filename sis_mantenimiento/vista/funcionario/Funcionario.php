<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  rcm
*@date 13/01/2012
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FuncionarioGem = {
	require:'../../../sis_organigrama/vista/funcionario/Funcionario.php',
	requireclase:'Phx.vista.funcionario',
	title:'Funcionarios',
	bdel: true,
	bedit: true,
	bnew: true,
	AtributosExtra:[
       	{
	       	config:{
	       			name: 'horario1',
	       			fieldLabel: "HH Normal (Bs./Hora)",
	       			gwidth: 120,
	       			allowBlank:false,	
	       			anchor:'50%',
	       			hiddenName:'horario1'
	       			
	       		},
	       		type:'NumberField',
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	     },
       	{
	       	config:{
	       			name: 'horario2',
	       			fieldLabel: "HH Extra (Bs./Hora)",
	       			gwidth: 120,
	       			allowBlank:true,	
	       			anchor:'50%',
	       			hiddenName:'horario2'
	       		},
	       		type:'NumberField',
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	     },
       	{
	       	config:{
	       			name: 'horario3',
	       			fieldLabel: "HH Nocturno (Bs./Hora)",
	       			gwidth: 120,
	       			allowBlank:true,	
	       			anchor:'50%',
	       			hiddenName:'horario3'
	       		},
	       		type:'NumberField',
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	     },
	     {
	       	config:{
	       			name: 'horario4',
	       			fieldLabel: "HH Fer. y Dom. (Bs./Hora)",
	       			gwidth: 120,
	       			allowBlank:true,	
	       			anchor:'50%',
	       			hiddenName:'horario4'
	       		},
	       		type:'NumberField',
	       		id_grupo:0,
	       		grid:true,
	       		form:true
	     },
	     {
       			config:{
       				name:'id_especialidades',
       				fieldLabel:'Especialidades Técnicas',
       				allowBlank:true,
       				tinit:true,
	    			tasignacion:true,
	    			tname:'id_especialidades',
	    			tdisplayField:'nombre',
	    			turl:'../../../sis_mantenimiento/vista/especialidad_tecnica/EspecialidadTecnica.php',
       				emptyText:'Especialidades...',
       				store: new Ext.data.JsonStore({
              			url: '../../sis_organigrama/control/Especialidad/listarEspecialidad',
       					id: 'id_especialidad',
       					root: 'datos',
       					sortInfo:{
       						field: 'nombre',
       						direction: 'ASC'
       					},
       					totalProperty: 'total',
       					fields: ['id_especialidad','codigo','nombre','desc_especialidad_nivel'],
       					remoteSort: true,
       					baseParams:{par_filtro:'espcia.nombre#espcia.codigo#espniv.nombre'}
       				}),
       				valueField: 'id_especialidad',
       				displayField: 'nombre',
       				forceSelection:true,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				anchor: '90%',
       				minChars:2,
	       			enableMultiSelect:true,
	       			hiddenName:'id_especialidades'
       			},
       			type:'AwesomeCombo',
       			id_grupo:0,
       			grid:false,
       			form:true
       	}
	],

	constructor: function(config) {
       	Phx.vista.FuncionarioGem.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}});
		
		this.form.add( 
                new Ext.Button(
                {fieldLabel:'Nueva especialidad',
                 text:'...',
                 icon:'key.gif',
                 cls:'x-form-trigger',
                 handler:function(){
                 	var data;
                 	Phx.CP.loadWindows('../../../sis_organigrama/vista/especialidad/Especialidad.php',
						'Especialidades',
						{
							width:'60%',
							height:'70%'
					    },
					    data,
					    this.idContenedor,
					    'Especialidad'
						);
                 	}
                 }));  
	},
	tabsouth:[{
		  url:'../../../sis_organigrama/vista/funcionario_especialidad/FuncionarioEspecialidad.php',
		  title:'Especialidades Funcionarios', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'FuncionarioEspecialidad'
		},
		{
		  url:'../../../sis_mantenimiento/vista/funcionario_honorario/FuncionarioHonorario.php',
		  title:'Honorarios', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'FuncionarioHonorario'
		}
	],
	ActSave:'../../sis_mantenimiento/control/Funcionario/guardarFuncionario',
	ActDel:'../../sis_mantenimiento/control/Funcionario/eliminarFuncionario',
	ActList:'../../sis_mantenimiento/control/Funcionario/listarFuncionario',
	onButtonEdit: function() {
		//Dfine como opcional el dato del horario 1
		this.getComponente('horario1').allowBlank=true;
		this.ocultarComponente(this.getComponente('id_especialidades'));
		this.ocultarComponente(this.getComponente('horario1'));
		this.ocultarComponente(this.getComponente('horario2'));
		this.ocultarComponente(this.getComponente('horario3'));
		this.ocultarComponente(this.getComponente('horario4'));
		Phx.vista.FuncionarioGem.superclass.onButtonEdit.call(this);
		
	},
	onButtonNew: function(){
		this.getComponente('horario1').allowBlank=false;
		this.mostrarComponente(this.getComponente('id_especialidades'));
		this.mostrarComponente(this.getComponente('horario1'));
		this.mostrarComponente(this.getComponente('horario2'));
		this.mostrarComponente(this.getComponente('horario3'));
		this.mostrarComponente(this.getComponente('horario4'));
		Phx.vista.FuncionarioGem.superclass.onButtonNew.call(this);
	},
    codReporte:'GMAN-RG-SM-030',
	codSistema:'GEM',
	pdfOrientacion:'L',
	title1: 'REGISTRO',
	title2:'Funcionarios',
	fechaRep:'26/05/2012'

};
</script>
