<?php
/**
*@package pXP
*@file AlmacenStock.php
*@author  Gonzalo Sarmiento 
*@date 01-10-2012
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AlmacenStock=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.AlmacenStock.superclass.constructor.call(this,config);
        this.init();
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    name: 'id_almacen_stock',
                    labelSeparator:'',
                    inputType:'hidden'                  
            },
            type:'Field',
            form:true 
        },
    
        {
            config:{
                name: 'id_almacen',
                labelSeparator:'',
                inputType:'hidden',
            },
            type:'Field',
            form:true
        },
        {
            config:{
                name:'id_item',
                fieldLabel:'Item',
                allowBlank:false,
                emptyText:'Item...',
                store: new Ext.data.JsonStore({

                    url: '../../sis_almacenes/control/Item/listarItemNotBase',
                    id: 'id_item',
                    root: 'datos',
                    sortInfo:{
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_item','nombre'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'nombre#cuenta'}
                }),
                valueField: 'id_item',
                displayField: 'nombre',
                gdisplayField:'nombre',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
                tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p> </div></tpl>',
                hiddenName: 'id_item',
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
                turl:'../../../sis_almacenes/vista/item/Item.php',
                ttitle:'Items',
               // tconfig:{width:1800,height:500},
                tdata:{},
                tcls:'item',
                pid:this.idContenedor,
            
                renderer:function (value, p, record){return String.format('{0}', record.data['desc_item']);}
            },
            type:'TrigguerCombo',
            //type:'ComboRec',
            id_grupo:0,
            filters:{   
                        pfiltro:'nombre',
                        type:'string'
                    },
           
            grid:true,
            form:true
        },
        {
            config:{
                name: 'cantidad_min',
                fieldLabel: 'Cantidad minima',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'NumberField',
            filters:{pfiltro:'almitem.cantidad_min',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'cantidad_alerta_amarilla',
                fieldLabel: 'Cant. alerta amarilla',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'NumberField',
            filters:{pfiltro:'almitem.cantidad_alerta_amarilla',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'cantidad_alerta_roja',
                fieldLabel: 'Cant. alerta roja',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:10
            },
            type:'NumberField',
            filters:{pfiltro:'almitem.cantidad_alerta_roja',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'estado_reg',
                fieldLabel: 'Estado Reg.',
                anchor: '80%',
                gwidth: 80
            },
            type:'TextField',
            filters:{pfiltro:'almitem.estado_reg',type:'string'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name:'id_usuario_reg',
                fieldLabel:'Id usuario reg.',
                anchor:'80%',
                gwidth: 100,                
            },
            type:'NumberField',
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'fecha_reg',
                fieldLabel: 'Fecha creación',
                anchor: '80%',
                //gwidth: 100,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
            },
            type:'DateField',
            filters:{pfiltro:'almitem.fecha_reg',type:'date'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name:'id_usuario_mod',
                fieldLabel:'Id usuario mod.',
                anchor:'80%',
                gwidth: 100,                
            },
            type:'NumberField',
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name: 'fecha_mod',
                fieldLabel: 'Fecha Modif.',
                anchor: '80%',
                //gwidth: 90,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
            },
            type:'DateField',
            filters:{pfiltro:'almitem.fecha_mod',type:'date'},
            id_grupo:1,
            grid:true,
            form:false
        }
    ],
    title:'Item por Almacen',
    ActSave:'../../sis_almacenes/control/AlmacenStock/insertarAlmacenItem',
    ActDel:'../../sis_almacenes/control/AlmacenStock/eliminarAlmacenItem',
    ActList:'../../sis_almacenes/control/AlmacenStock/listarAlmacenItem',
    id_store:'id_almacen_stock',
    fields: [
        {name:'id_almacen_stock', type: 'numeric'},     
        {name:'id_almacen', type: 'numeric'},
        {name:'id_item', type: 'numeric'},
        {name:'desc_item', type: 'string'},
        {name:'estado_reg', type: 'string'},        
        {name:'cantidad_min', type: 'numeric'},
        {name:'cantidad_alerta_amarilla', type: 'numeric'},
        {name:'cantidad_alerta_roja', type: 'numeric'},
        {name:'id_usuario_reg',type:'integer'},
        {name:'fecha_reg',type:'timestamp'},
        {name:'id_usuario_mod',type:'integer'},
        {name:'fecha_mod',type:'timestamp'}     
    ],
    sortInfo:{
        field: 'id_almacen_stock',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true,
    
    onReloadPage:function(m){

       
        this.maestro=m;
        this.Atributos[1].valorInicial=this.maestro.id_almacen;


        // this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);

       if(m.id != 'id'){
        //   this.grid.getTopToolbar().enable();
        //   this.grid.getBottomToolbar().enable();  

        this.store.baseParams={id_almacen:this.maestro.id_almacen};
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
        
        