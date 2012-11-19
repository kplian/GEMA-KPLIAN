<?php
/**
 * @package         pxP
 * @file            Salida.php
 * @author          Gonzalo Sarmiento
 * @descripcion     Archivo con las interfaz de usuario que permite la funcionalidad de finalizar una Salida
 * @date            09-10-2012 
 */
 include_once("SalidaAbs.php");
 header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Salida=Ext.extend(Phx.vista.SalidaAbs,{
        constructor : function(config){
            this.maestro = config.maestro;
            Phx.vista.Salida.superclass.constructor.call(this,config);
            this.init();
            this.addButton('FinSalida',{text:'Finalizar',iconCls:'bend',disabled:true,handler:FinSalida,tooltip:'<b>Finalizar Salida'});
            
            function FinSalida(){                   
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
            this.load({params:{start:0, limit:50, codigo:'SALIDA'}})
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
        title:'Salida',
        bdel:true,
        bend:true,
        bedit:true,
        bnew:true,
        preparaMenu:function(tb){
            //llamada funcion clace padre
            if(this.sm.getSelected().data.estado_mov=='borrador'){              
                this.getBoton('FinSalida').enable();
            }
            else{                   
                this.getBoton('FinSalida').disable();               
            }
            Phx.vista.Salida.superclass.preparaMenu.call(this,tb);
        }
    })
</script>
