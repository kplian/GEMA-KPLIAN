<?php
/**
 * @package         pxP
 * @file            Ingreso.php
 * @author          Gonzalo Sarmiento
 * @descripcion     Archivo con las interfaz de usuario que permite la funcionalidad de finalizar un Ingreso
 * @date            09-10-2012 
 */
 include_once("IngresoAbs.php");
 header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Ingreso=Ext.extend(Phx.vista.IngresoAbs,{
        constructor : function(config){
            this.maestro = config.maestro;
            Phx.vista.Ingreso.superclass.constructor.call(this,config);
            this.init();
            this.addButton('FinIngreso',{text:'Finalizar',iconCls:'bend',disabled:true,handler:FinIngreso,tooltip:'<b>Finzalizar Ingreso'});
            
            function FinIngreso(){                  
                var data=this.sm.getSelected().data.id_movimiento;
                Phx.CP.loadingShow();
                Ext.Ajax.request({
                    // form:this.form.getForm().getEl(),
                    url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
                    params:{'id_movimiento':data,'operacion':'finalizar'},
                    success:this.successSinc,
                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
                });     
            }
            this.load({params:{start:0, limit:50, codigo:'INGRESO'}})
        },
        successSinc:function(resp){
            
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                alert(reg.ROOT.detalle.mensaje)
                
            }else{
                
                alert('ocurrio un error durante el proceso')
            }
            this.reload();
            
        },      
        title:'Ingreso',
        bdel:true,
        bend:true,
        bnew:true,
        bedit:true,
        preparaMenu:function(tb){
            //llamada funcion clace padre
            if(this.sm.getSelected().data.estado_mov=='borrador'){              
                this.getBoton('FinIngreso').enable();
            }
            else{                   
                this.getBoton('FinIngreso').disable();          
            }
            Phx.vista.Ingreso.superclass.preparaMenu.call(this,tb);
        }
    })
</script>
