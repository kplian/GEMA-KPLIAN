<?php
/**
*@package pXP
*@file gen-UniCons.php
*@author  rcm
*@date 14/05/2013
*@description Inventario de equipos
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UniConsInvent=Ext.extend(Phx.gridInterfaz,{
	tam_pag:50,
	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.UniConsInvent.superclass.constructor.call(this,config);
		this.init();
		if(this.maestro.id!='id'){
			var id_loc;
			if(isNaN(this.maestro.id_localizacion)){
				id_loc=0;
			} else{
				id_loc= this.maestro.id_localizacion
			}
			this.load({params:{start:0,
				limit:this.tam_pag,
				id_localizacion:id_loc,
				tipo_nodo:this.maestro.tipo_nodo,
				id_uni_cons:this.maestro.id_uni_cons
				}
			})
        	//this.loadValoresIniciales();
		}
				

	},
			
	Atributos:[
		{
			//configuracion del componente
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
				name: 'localiz',
				fieldLabel: 'Localización',
				gwidth: 150
			},
			type:'TextField',
			filters:{pfiltro:'locp4.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'est_pla',
				fieldLabel: 'Estación/Planta',
				gwidth: 150
			},
			type:'TextField',
			filters:{pfiltro:'locp3.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'lugar',
				fieldLabel: 'Lugar',
				gwidth: 150
			},
			type:'TextField',
			filters:{pfiltro:'locp2.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'unidad',
				fieldLabel: 'Unidad',
				gwidth: 150
			},
			type:'TextField',
			filters:{pfiltro:'locp1.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'tipo_equipo',
				fieldLabel: 'Tipo Equipo',
				gwidth: 250
			},
			type:'TextField',
			filters:{pfiltro:'eqgral.nombre',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre Equipo',
				gwidth: 250
			},
			type:'TextField',
			filters:{pfiltro:'eqgral.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				gwidth: 150
			},
			type:'TextField',
			filters:{pfiltro:'eqgral.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				gwidth: 100
			},
			type:'TextField',
			filters:{pfiltro:'eqgral.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				gwidth: 100,
				hidden:true
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				gwidth: 100,
				format: 'd/m/Y', 
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'equipo.fecha_reg',type:'date'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				gwidth: 100,
				hidden:true
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				gwidth: 100,
				format: 'd/m/Y', 
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'equipo.fecha_mod',type:'date'},
			id_grupo:1,
			grid:false,
			form:true
		}
	],
	
	title:'INVENTARIO EQUIPOS',
	ActList:'../../sis_mantenimiento/control/UniCons/listarUniConsInvent',
	id_store:'codigo',
	fields: [
		{name:'localiz', type: 'numeric'},
		{name:'est_pla', type: 'numeric'},
		{name:'lugar', type: 'numeric'},
		{name:'unidad', type: 'string'},
		{name:'tipo_equipo', type: 'numeric'},
		{name:'nombre', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}
	],
	sortInfo:{
		field: 'localiz,est_pla,lugar,unidad',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
	bedit:false,
	bnew:false,
	/*loadValoresIniciales: function() {
		//console.log(this.maestro);
		Phx.vista.UniConsInvent.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);
	},*/
	onReloadPage: function(m) {
		//console.log(this.maestro)
		this.maestro=m;	
		if(this.maestro.id!='id'){
			var id_loc;
			if(isNaN(this.maestro.id_localizacion)){
				id_loc=0;
			} else{
				id_loc= this.maestro.id_localizacion
			}
			this.store.baseParams={id_localizacion:id_loc,tipo_nodo:this.maestro.tipo_nodo,id_uni_cons:this.maestro.id_uni_cons};
			this.load({params:{start:0, limit:this.tam_pag}});	
		}
		
	},
    codReporte:'GMAN-RG-SM-004',
	codSistema:'GEM',
	pdfOrientacion:'L',
	title1:'REGISTRO',
	title2:'Inventario de Equipos'
})
</script>
		
		