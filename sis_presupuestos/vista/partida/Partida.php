<?php
/**
*@package pXP
*@file gen-Partida.php
*@author  (admin)
*@date 23-11-2012 20:06:53
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Partida=Ext.extend(Phx.arbInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Partida.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_partida'
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
			filters:{pfiltro:'par.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'id_partida_fk',
				inputType:'hidden'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'tipo',
				fieldLabel: 'Tipo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:15
			},
			type:'TextField',
			filters:{pfiltro:'par.tipo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
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
			filters:{pfiltro:'par.codigo',type:'string'},
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
            filters:{pfiltro:'par.descripcion',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'par.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Partida',
	ActSave:'../../sis_presupuestos/control/Partida/insertarPartida',
	ActDel:'../../sis_presupuestos/control/Partida/eliminarPartida',
	ActList:'../../sis_presupuestos/control/Partida/listarPartidaArb',
	id_store:'id_partida',
	textRoot:'PARTIDAS',
    id_nodo:'id_partida',
    id_nodo_p:'id_partida_fk',
	fields: [
		'id',
        'tipo_meta',
		{name:'id_partida', type: 'numeric'},
		{name:'id_partida_fk', type: 'numeric'},
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
		field: 'id_partida',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	rootVisible:true,
	
	onButtonNew:function(){
        var nodo = this.sm.getSelectedNode();           
        Phx.vista.Partida.superclass.onButtonNew.call(this);
    },
    
    preparaMenu:function(n){
        if(n.attributes.tipo_nodo == 'hijo' || n.attributes.tipo_nodo == 'raiz' || n.attributes.id == 'id'){
            this.tbar.items.get('b-new-'+this.idContenedor).enable()
        }
        else {
            this.tbar.items.get('b-new-'+this.idContenedor).disable()
        }
        // llamada funcion clase padre
            Phx.vista.Partida.superclass.preparaMenu.call(this,n);
    },
    
    EnableSelect:function(n){
        var nivel = n.getDepth();
        var direc = this.getNombrePadre(n)
        if(direc){            
            Phx.vista.Partida.superclass.EnableSelect.call(this,n)
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
     }
}
)
</script>
		
		