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
Phx.vista.DetalleMateriales=Ext.extend(Phx.gridInterfaz,{

    constructor:function(config){
        this.maestro=config.maestro;
        //llama al constructor de la clase padre
        Phx.vista.DetalleMateriales.superclass.constructor.call(this,config);
        this.init();
    },
            
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_movimiento_det'
            },
            type:'Field',
            form:true 
        },
    
        {
            config:{
                name: 'id_movimiento',
                labelSeparator:'',
                anchor: '80%',
                inputType:'hidden',
                maxLength:5
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
                width:275,
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
                name: 'cantidad',
                fieldLabel: 'Cantidad',
                allowBlank: true,
                anchor: '80%',
                gwidth: 70,
                maxLength:6
            },
            type:'NumberField',
            filters:{pfiltro:'movdet.cantidad',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'costo_unitario',
                fieldLabel: 'Costo unitario',
                allowBlank: true,
                anchor: '80%',
                gwidth: 90,
                maxLength:10
            },
            type:'NumberField',
            filters:{pfiltro:'movdet.costo_unitario',type:'numeric'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'fecha_caducidad',
                fieldLabel: 'Fecha de caducidad',
                allowBlank: true,
                anchor: '80%',
                //gwidth: 120,
                renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                format:'d/m/Y'              
            },
            type:'DateField',
            filters:{pfiltro:'movdet.fecha_caducidad',type:'date'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name:'id_usuario_reg',
                fieldLabel: 'Id usuario reg.',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength: 5
            },
            type:'NumberField',
            id_grupo:1,
            grid: true,
            form: false
        },
        {
            config:{
                name: 'fecha_reg',
                fieldLabel: 'Fecha registro',
                allowBlank: true,
                anchor: '80%',
                //gwidth: 110,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
            },
            type:'DateField',
            filters:{pfiltro:'movdet.fecha_reg',type:'date'},
            id_grupo:1,
            grid:true,
            form:false
        },
        {
            config:{
                name:'id_usuario_mod',
                fieldLabel: 'Id usuario modif.',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength: 5
            },
            type:'NumberField',
            id_grupo:1,
            grid: true,
            form: false
        },
        {
            config:{
                name: 'fecha_mod',
                fieldLabel: 'Fecha de modif.',
                anchor: '80%',
                //gwidth: 110,
                //renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                format:'d/m/Y'
            },
            type:'DateField',
            id_grupo:1,
            grid:true,
            form:false
        }
    ],
    title:'Detalle por Material',
    ActSave:'../../sis_almacenes/control/DetalleMateriales/insertarDetalleMateriales',
    ActDel:'../../sis_almacenes/control/DetalleMateriales/eliminarDetalleMateriales',
    ActList:'../../sis_almacenes/control/DetalleMateriales/listarDetalleMateriales',
    id_store:'id_movimiento_det',
    fields: [
        {name:'id_movimiento_det', type: 'numeric'},        
        {name:'id_movimiento', type: 'numeric'},
        {name:'id_item', type: 'numeric'},
        {name:'desc_item', type: 'string'},
        {name:'estado_reg', type: 'string'},        
        {name:'cantidad', type: 'numeric'},
        {name:'costo_unitario', type: 'numeric'},
        {name:'fecha_caducidad', type: 'date'},
        {name:'id_usuario_reg',type:'numeric'},
        {name:'fecha_reg',type:'timestamp'},
        {name:'id_usuario_mod',type:'numeric'},
        {name:'fecha_mod',type:'timestamp'}
    ],
    sortInfo:{
        field: 'id_movimiento_det',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true,
    
    onReloadPage:function(m){

       
        this.maestro=m;
        this.Atributos[1].valorInicial=this.maestro.id_movimiento;


        // this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);

       if(m.id != 'id'){
        //   this.grid.getTopToolbar().enable();
        //   this.grid.getBottomToolbar().enable();  

        this.store.baseParams={id_movimiento:this.maestro.id_movimiento};
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
        
        