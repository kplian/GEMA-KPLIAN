<?php
/**
*@package   pXP
*@file      AlmacenUsuario.php
*@author    Gonzalo Sarmiento Sejas
*@date      13-11-2012 01:30:22
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AlmacenUsuario=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.AlmacenUsuario.superclass.constructor.call(this,config);
        this.init();        
        this.load({params:{start:0, limit:50}})
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_almacen_usuario'
            },
            type:'Field',
            form:true 
        },
        {
            config:{
                name:'id_usuario',
                fieldLabel:'Usuario',
                allowBlank:true,
                emptyText:'Usuario...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_seguridad/control/Usuario/listarUsuario',
                    id: 'id_clasificador',
                    root: 'datos',
                    sortInfo:{
                        field: 'cuenta',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_usuario','cuenta','desc_person'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'cuenta#desc_person'}
                }),
                valueField: 'id_usuario',
                displayField: 'cuenta',
                gdisplayField: 'desc_person',
                hiddenName: 'id_usuario',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                minChars:2,            
                renderer:function(value, p, record){return String.format('{0}', record.data['cuenta']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'cuenta',
                type:'string'
            },
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
            filters:{pfiltro:'almusr.estado_reg',type:'string'},
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
            filters:{pfiltro:'almusr.fecha_reg',type:'date'},
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
            filters:{pfiltro:'almusr.fecha_mod',type:'date'},
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
    title:'Usuarios de almacenes',
    ActSave:'../../sis_almacenes/control/AlmacenUsuario/insertarAlmacenUsuario',
    ActDel:'../../sis_almacenes/control/AlmacenUsuario/eliminarAlmacenUsuario',
    ActList:'../../sis_almacenes/control/AlmacenUsuario/listarAlmacenUsuario',
    id_store:'id_almacen_usuario',
    fields: [
        {name:'id_almacen_usuario', type: 'numeric'},
        {name:'id_usuario', type: 'numeric'},
        {name:'cuenta', type: 'string'},
        {name:'estado_reg', type: 'string'},
        {name:'id_usuario_reg', type: 'numeric'},
        {name:'fecha_reg', type: 'timestamp'},
        {name:'fecha_mod', type: 'timestamp'},
        {name:'id_usuario_mod', type: 'numeric'},
        {name:'usr_reg', type: 'string'},
        {name:'usr_mod', type: 'string'},
        
    ],
    sortInfo:{
        field: 'id_almacen_usuario',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true
    }
)
</script>
			
		