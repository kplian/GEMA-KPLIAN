<?php
/**
*@package pXP
*@file gen-DiagramaDecicionAccion.php
*@author  (admin)
*@date 23-11-2012 20:06:53
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DiagramaDecisionAccion=Ext.extend(Phx.arbInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
		//console.log(config)
    	//llama al constructor de la clase padre
		Phx.vista.DiagramaDecisionAccion.superclass.constructor.call(this,config);
		this.init();
		this.root.ui.hide();		
        this.treePanel.getTopToolbar().disable();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_diagrama_decision_accion'
			},
			type:'Field',
			form:true 
		},
		{
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_diagrama_decision'
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
			filters:{pfiltro:'gediac.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'id_diagrama_decision_accion_fk',
				inputType:'hidden'
			},
			type:'Field',
			form:true
		},
		{
			config: {
				name: 'tipo',
				fieldLabel: 'Tipo',
				anchor: '90%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'tdiagrama_decision_accion'
					}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'gediac.tipo',type:'string'},
			grid: true,
			form: true
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
			filters:{pfiltro:'gediac.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
        {
            config:{
                name: 'nombre',
                fieldLabel: 'Nombre',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:200
            },
            type:'TextField',
            filters:{pfiltro:'gediac.nombre',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4,
				hidden:true
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'par.fecha_reg',type:'date'},
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
				maxLength:4,
				hidden:true
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'par.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Diagrama Decision Accion',
	ActSave:'../../sis_mantenimiento/control/DiagramaDecisionAccion/insertarDiagramaDecisionAccion',
	ActDel:'../../sis_mantenimiento/control/DiagramaDecisionAccion/eliminarDiagramaDecisionAccion',
	ActList:'../../sis_mantenimiento/control/DiagramaDecisionAccion/listarDiagramaDecisionAccionArb',
	id_store:'id_diagrama_decision',
	textRoot:'Diagrama de Decision',
    id_nodo:'id_diagrama_decision_accion',
    id_nodo_p:'id_diagrama_decision_accion_fk',
	fields: [
		'id',
        'tipo_meta',
        {name:'id_diagrama_decision', type: 'numeric'},
		{name:'id_diagrama_decision_accion', type: 'numeric'},
		{name:'id_diagrama_decision_accion_fk', type: 'numeric'},
		{name:'tipo', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_diagrama_decision_accion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	rootVisible:true,
	expanded:false,
	
	onButtonNew:function(){
        var nodo = this.sm.getSelectedNode();           
        Phx.vista.DiagramaDecisionAccion.superclass.onButtonNew.call(this);
    },
    
    preparaMenu:function(n){
        var tiponodo = n.attributes.tipo_nodo;        
        if(tiponodo == 'hijo' || tiponodo == 'raiz' || n.attributes.id == 'id'){
            this.tbar.items.get('b-new-'+this.idContenedor).enable()
        }
        else {
            this.tbar.items.get('b-new-'+this.idContenedor).disable()
        }
        // llamada funcion clase padre
            Phx.vista.DiagramaDecisionAccion.superclass.preparaMenu.call(this,n);
    },
    
    EnableSelect:function(n){
        var nivel = n.getDepth();
        var direc = this.getNombrePadre(n)
        if(direc){            
            Phx.vista.DiagramaDecisionAccion.superclass.EnableSelect.call(this,n)
        }        
    },
    
    getNombrePadre:function(n){
        var direc
        var padre = n.parentNode;
        if(padre){
            if(padre.attributes.id!='id'){
               direc = n.attributes.nombre +' - '+ this.getNombrePadre(padre)
               return direc;
            }else{
                
                return n.attributes.nombre;
            }
        }
        else{
                return undefined;
        }       
     },
     loadValoresIniciales:function(){
		Phx.vista.DiagramaDecisionAccion.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_diagrama_decision').setValue(this.maestro.id_diagrama_decision);		
	},
	onReloadPage:function(m){
	    this.root.ui.show();
		this.maestro=m;
		
		if(this.maestro.id_diagrama_decision!='' && this.maestro.id_diagrama_decision!=undefined){				
    		this.loaderTree.baseParams={id_diagrama_decision:this.maestro.id_diagrama_decision};
    		this.root.reload();
    		this.paramsCheck={id_diagrama_decision:this.maestro.id_diagrama_decision};
    		//this.tbar.items.get('b-new-'+this.idContenedor).disable();
    	}
        else{
            this.getBoton('act').disable();
        }			
	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		