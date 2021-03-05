[{if !isset($noFormSubmit)}][{assign var="noFormSubmit" value=null}][{/if}]
[{if !isset($deladr)}][{assign var="deladr" value=null}][{/if}]
[{if !isset($countrySelectId)}][{assign var="countrySelectId" value=null}][{/if}]

[{if $oxcmp_user}]
    [{assign var="delivadr" value=$oxcmp_user->getSelectedAddress()}]
[{/if}]

[{if !$deladr}]
    [{assign var="oConfig" value=$oView->getConfig()}]
    [{assign var="deladr"  value=$oConfig->getRequestParameter('deladr')}]
[{/if}]

[{if $oxcmp_user}]
    [{assign var="aUserAddresses" value=$oxcmp_user->getUserAddresses()}]

    [{if $aUserAddresses|@count > 0}]
        [{if $onChangeClass == 'user'}]
            <div class="col-lg-9 col-lg-offset-3">
        [{/if}]

            <input type="hidden" class="hidden" name="changeClass" value="[{$onChangeClass|default:'account_user'}]">

            [{oxscript include="js/widgets/oxusershipingaddressselect.min.js" priority=10}]
            [{oxscript include="js/widgets/oxequalizer.min.js" priority=10}]
            [{oxscript add="$( '.dd-add-delivery-address' ).click( function() {  $('.dd-available-addresses .dd-action').remove(); $( this ).find( 'label.btn' ).button('toggle'); } );"}]
            [{oxscript add="$( 'input[name=\"oxaddressid\"]' ).oxUserShipingAddressSelect();"}]
            [{oxscript add="$( window ).load( function() { if( !isMobileDevice() ) { oxEqualizer.equalHeight( $( '.dd-available-addresses .panel .panel-body' ) ); } } );"}]
            [{oxscript add="$( '.dd-edit-shipping-address' ).click(function(){ $( '#shippingAddressForm' ).show(); $( 'html, body' ).animate( { scrollTop: $( '#shippingAddressForm' ).offset().top - 80 }, 600 ); } );"}]

            [{block name="form_user_shipping_address_select"}]
                <div class="row dd-available-addresses" data-toggle="buttons">
                    [{foreach from=$aUserAddresses item=address name="shippingAdresses"}]
                        <div class="col-xs-12 col-md-6 col-lg-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    [{block name="form_user_shipping_address_actions"}]
                                    [{if $address->isSelected()}]
                                        [{block name="form_user_shipping_address_edit_action"}]
                                        <button class="btn btn-warning btn-xs hasTooltip pull-right dd-action dd-edit-shipping-address" title="[{oxmultilang ident="CHANGE"}]">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                        [{/block}]
                                        [{block name="form_user_shipping_address_delete_action"}]
                                        <button class="btn btn-danger btn-xs hasTooltip pull-right dd-action dd-delete-shipping-address"
                                                title="[{oxmultilang ident="DD_DELETE"}]"
                                                data-toggle="modal"
                                                data-target="#delete_shipping_address_[{$smarty.foreach.shippingAdresses.iteration}]">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                        [{/block}]
                                    [{/if}]
                                    [{/block}]
                                    [{include file="widget/address/shipping_address.tpl" delivadr=$address}]
                                </div>
                                <div class="panel-footer" >
                                    <label class="btn btn-default btn-block[{if $address->isSelected()}] active[{/if}]">
                                        <input type="radio" name="oxaddressid" value="[{$address->oxaddress__oxid->value}]" class="hidden" autocomplete="off" [{if $address->isSelected()}]checked[{/if}]><i class="fa fa-check"></i> [{oxmultilang ident="DD_USER_SHIPPING_SELECT_ADDRESS"}]
                                    </label>
                                </div>
                            </div>
                        </div>
                    [{/foreach}]

                    <div class="col-xs-12 col-md-6 col-lg-4">
                        <div class="panel panel-default dd-add-delivery-address">
                            <div class="panel-body text-center">
                                <i class="fa fa-plus-circle"></i><br/>
                                [{oxmultilang ident="DD_USER_SHIPPING_ADD_DELIVERY_ADDRESS"}]
                            </div>
                            <div class="panel-footer" >
                                <label class="btn btn-default btn-block">
                                    <input type="radio" name="oxaddressid" value="-1" class="hidden" autocomplete="off"><i class="fa fa-check"></i> [{oxmultilang ident="DD_USER_SHIPPING_SELECT_ADDRESS"}]
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            [{/block}]

        [{if $onChangeClass == 'user'}]
            </div>
        [{/if}]

        <div class="clearfix"></div>
    [{/if}]
[{/if}]

<div id="shippingAddressForm" [{if $delivadr}]style="display: none;"[{/if}]>
    <div class="form-group">
        <label class="control-label col-lg-3[{if $oView->isFieldRequired(oxaddress__oxsal)}] req[{/if}]" for="deladr_oxaddress__oxsal">[{oxmultilang ident="TITLE"}]</label>
        <div class="col-lg-2">
            [{if isset($delivadr->oxaddress__oxsal->value)}][{assign var="userAddress" value=$delivadr->oxaddress__oxsal->value}][{else}][{assign var="userAddress" value=null}][{/if}]
            [{if isset($deladr.oxaddress__oxsal)}][{assign var="requestAddress" value=$deladr.oxaddress__oxsal}][{else}][{assign var="requestAddress" value=null}][{/if}]
            [{include file="form/fieldset/salutation.tpl" name="deladr[oxaddress__oxsal]" value=$userAddress value2=$requestAddress class="form-control selectpicker" id="deladr_oxaddress__oxsal"}]
        </div>
    </div>
    [{if isset($aErrors.oxaddress__oxfname)}][{assign var="addressFirstNameErrors" value=$aErrors.oxaddress__oxfname}][{else}][{assign var="addressFirstNameErrors" value=null}][{/if}]
    <div class="form-group[{if $addressFirstNameErrors}] oxInValid[{/if}]">
        <label class="control-label col-lg-3[{if $oView->isFieldRequired(oxaddress__oxfname)}] req[{/if}]">[{oxmultilang ident="FIRST_NAME"}]</label>
        <div class="col-lg-9">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxfname)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" maxlength="255" name="deladr[oxaddress__oxfname]" value="[{if isset( $deladr.oxaddress__oxfname )}][{$deladr.oxaddress__oxfname}][{elseif isset($delivadr->oxaddress__oxfname->value)}][{$delivadr->oxaddress__oxfname->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxfname)}] required=""[{/if}]>
            [{if $oView->isFieldRequired(oxaddress__oxfname)}]
                [{include file="message/inputvalidation.tpl" aErrors=$addressFirstNameErrors}]
                <div class="help-block"></div>
            [{/if}]
        </div>
    </div>
    [{if isset($aErrors.oxaddress__oxlname)}][{assign var="addressLastNameErrors" value=$aErrors.oxaddress__oxlname}][{else}][{assign var="addressLastNameErrors" value=null}][{/if}]
    <div class="form-group[{if $addressLastNameErrors}] oxInValid[{/if}]">
        <label class="control-label col-lg-3[{if $oView->isFieldRequired(oxaddress__oxlname)}] req[{/if}]">[{oxmultilang ident="LAST_NAME"}]</label>
        <div class="col-lg-9">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxlname)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" maxlength="255" name="deladr[oxaddress__oxlname]" value="[{if isset( $deladr.oxaddress__oxlname )}][{$deladr.oxaddress__oxlname}][{elseif isset($delivadr->oxaddress__oxlname->value)}][{$delivadr->oxaddress__oxlname->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxlname)}] required=""[{/if}]>
            [{if $oView->isFieldRequired(oxaddress__oxlname)}]
                [{include file="message/inputvalidation.tpl" aErrors=$addressLastNameErrors}]
                <div class="help-block"></div>
            [{/if}]
        </div>
    </div>
    [{if isset($aErrors.oxaddress__oxcompany)}][{assign var="addressCompanyErrors" value=$aErrors.oxaddress__oxcompany}][{else}][{assign var="addressCompanyErrors" value=null}][{/if}]
    <div class="form-group[{if $addressCompanyErrors}] oxInValid[{/if}]">
        <label class="control-label col-lg-3[{if $oView->isFieldRequired(oxaddress__oxcompany)}] req[{/if}]">[{oxmultilang ident="COMPANY"}]</label>
        <div class="col-lg-9">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxcompany)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" size="37" maxlength="255" name="deladr[oxaddress__oxcompany]" value="[{if isset( $deladr.oxaddress__oxcompany )}][{$deladr.oxaddress__oxcompany}][{elseif isset($delivadr->oxaddress__oxcompany->value)}][{$delivadr->oxaddress__oxcompany->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxcompany)}] required=""[{/if}]>
            [{if $oView->isFieldRequired(oxaddress__oxcompany)}]
                [{include file="message/inputvalidation.tpl" aErrors=$addressCompanyErrors}]
            [{/if}]
            <div class="help-block"></div>
        </div>
    </div>
    [{if isset($aErrors.oxaddress__oxaddinfo)}][{assign var="addressAdditionalErrors" value=$aErrors.oxaddress__oxaddinfo}][{else}][{assign var="addressAdditionalErrors" value=null}][{/if}]
    <div class="form-group[{if $addressAdditionalErrors}] oxInValid[{/if}]">
        [{assign var="_address_addinfo_tooltip" value="FORM_FIELDSET_USER_SHIPPING_ADDITIONALINFO2_TOOLTIP"|oxmultilangassign}]
        <label [{if $_address_addinfo_tooltip}]title="[{$_address_addinfo_tooltip}]"[{/if}] class="control-label col-lg-3[{if $oView->isFieldRequired(oxaddress__oxaddinfo)}] req[{/if}][{if $_address_addinfo_tooltip}] tooltip[{/if}]">[{oxmultilang ident="ADDITIONAL_INFO"}]</label>
        <div class="col-lg-9">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxaddinfo)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" size="37" maxlength="255" name="deladr[oxaddress__oxaddinfo]" value="[{if isset( $deladr.oxaddress__oxaddinfo )}][{$deladr.oxaddress__oxaddinfo}][{elseif isset($delivadr->oxaddress__oxaddinfo->value)}][{$delivadr->oxaddress__oxaddinfo->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxaddinfo)}] required=""[{/if}]>
            [{if $oView->isFieldRequired(oxaddress__oxaddinfo)}]
                [{include file="message/inputvalidation.tpl" aErrors=$addressAdditionalErrors}]
            [{/if}]
            <div class="help-block"></div>
        </div>
    </div>
    [{if isset($aErrors.oxaddress__oxstreet)}][{assign var="addressStreetErrors" value=$aErrors.oxaddress__oxstreet}][{else}][{assign var="addressStreetErrors" value=null}][{/if}]
    <div class="form-group[{if $addressStreetErrors}] oxInValid[{/if}]">
        <label class="control-label col-xs-12 col-lg-3[{if $oView->isFieldRequired(oxaddress__oxstreet) || $oView->isFieldRequired(oxaddress__oxstreetnr)}] req[{/if}]">[{oxmultilang ident="STREET_AND_STREETNO"}]</label>
        <div class="col-xs-8 col-lg-6">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxstreet)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" data-fieldsize="pair-xsmall" maxlength="255" name="deladr[oxaddress__oxstreet]" value="[{if isset( $deladr.oxaddress__oxstreet )}][{$deladr.oxaddress__oxstreet}][{elseif isset($delivadr->oxaddress__oxstreet->value)}][{$delivadr->oxaddress__oxstreet->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxstreet)}] required=""[{/if}]>
        </div>
        <div class="col-xs-4 col-lg-3">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxstreetnr)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" data-fieldsize="xsmall" maxlength="16" name="deladr[oxaddress__oxstreetnr]" value="[{if isset( $deladr.oxaddress__oxstreetnr )}][{$deladr.oxaddress__oxstreetnr}][{elseif isset($delivadr->oxaddress__oxstreetnr->value)}][{$delivadr->oxaddress__oxstreetnr->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxstreetnr)}] required=""[{/if}]>
        </div>
        <div class="col-lg-offset-3 col-lg-9 col-xs-12">
            [{if $oView->isFieldRequired(oxaddress__oxstreet) || $oView->isFieldRequired(oxaddress__oxstreetnr)}]
                <div class="help-block"></div>
                [{include file="message/inputvalidation.tpl" aErrors=$addressStreetErrors}]
            [{/if}]
        </div>
    </div>
    [{if isset($aErrors.oxaddress__oxzip)}][{assign var="addressZipErrors" value=$aErrors.oxaddress__oxzip}][{else}][{assign var="addressZipErrors" value=null}][{/if}]
    [{if isset($aErrors.oxaddress__oxcity)}][{assign var="addressCityErrors" value=$aErrors.oxaddress__oxcity}][{else}][{assign var="addressCityErrors" value=null}][{/if}]
    <div class="form-group[{if $addressZipErrors || $addressCityErrors}] oxInValid[{/if}]">
        <label class="control-label col-xs-12 col-lg-3[{if $oView->isFieldRequired(oxaddress__oxzip) || $oView->isFieldRequired(oxaddress__oxcity)}] req[{/if}]">[{oxmultilang ident="POSTAL_CODE_AND_CITY"}]</label>
        <div class="col-xs-5 col-lg-3">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxzip)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" data-fieldsize="small" maxlength="50" name="deladr[oxaddress__oxzip]" value="[{if isset( $deladr.oxaddress__oxzip )}][{$deladr.oxaddress__oxzip}][{elseif isset($delivadr->oxaddress__oxzip->value)}][{$delivadr->oxaddress__oxzip->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxzip)}] required=""[{/if}]>
        </div>
        <div class="col-xs-7 col-lg-6">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxcity)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" data-fieldsize="pair-small" maxlength="255" name="deladr[oxaddress__oxcity]" value="[{if isset( $deladr.oxaddress__oxcity )}][{$deladr.oxaddress__oxcity}][{elseif isset($delivadr->oxaddress__oxcity->value)}][{$delivadr->oxaddress__oxcity->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxcity)}] required=""[{/if}]>
        </div>
        <div class="col-lg-offset-3 col-md-9 col-xs-12">
            [{if $oView->isFieldRequired(oxaddress__oxzip) || $oView->isFieldRequired(oxaddress__oxcity)}]
                [{include file="message/inputvalidation.tpl" aErrors=$addressZipErrors}]
                [{include file="message/inputvalidation.tpl" aErrors=$addressCityErrors}]
                <div class="help-block"></div>
            [{/if}]
        </div>
    </div>
    [{block name="form_user_shipping_country"}]
    [{if isset($aErrors.oxaddress__oxcountryid)}][{assign var="addressCountryErrors" value=$aErrors.oxaddress__oxcountryid}][{else}][{assign var="addressCountryErrors" value=null}][{/if}]
    <div class="form-group[{if $addressCountryErrors}] oxInValid[{/if}]">
            <label class="control-label col-lg-3[{if $oView->isFieldRequired(oxaddress__oxcountryid)}] req[{/if}]" for="delCountrySelect">[{oxmultilang ident="COUNTRY"}]</label>
            <div class="col-lg-9">
                <select class="form-control[{if $oView->isFieldRequired(oxaddress__oxcountryid)}] js-oxValidate js-oxValidate_notEmpty[{/if}] selectpicker" id="delCountrySelect" name="deladr[oxaddress__oxcountryid]"[{if $oView->isFieldRequired(oxaddress__oxcountryid)}] required=""[{/if}]>
                    <option value="">-</option>
                    [{assign var="blCountrySelected" value=false}]
                    [{foreach from=$oViewConf->getCountryList() item=country key=country_id}]
                        [{assign var="sCountrySelect" value=""}]
                        [{if !$blCountrySelected}]
                            [{if (isset($deladr.oxaddress__oxcountryid) && $deladr.oxaddress__oxcountryid == $country->oxcountry__oxid->value) ||
                                 (!isset($deladr.oxaddress__oxcountryid) && ($delivadr->oxaddress__oxcountry->value == $country->oxcountry__oxtitle->value or
                                  $delivadr->oxaddress__oxcountry->value == $country->oxcountry__oxid->value or
                                  $delivadr->oxaddress__oxcountryid->value == $country->oxcountry__oxid->value))}]
                                [{assign var="blCountrySelected" value=true}]
                                [{assign var="sCountrySelect" value="selected"}]
                            [{/if}]
                        [{/if}]
                        <option value="[{$country->oxcountry__oxid->value}]" [{$sCountrySelect}]>[{$country->oxcountry__oxtitle->value}]</option>
                    [{/foreach}]
                </select>
                [{if $oView->isFieldRequired(oxaddress__oxcountryid)}]
                    [{include file="message/inputvalidation.tpl" aErrors=$addressCountryErrors}]
                    <div class="help-block"></div>
                [{/if}]
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-lg-3" for="[{$countrySelectId}]">[{oxmultilang ident="DD_USER_SHIPPING_LABEL_STATE"}]</label>
            [{if isset($delivadr->oxaddress__oxstateid->value)}][{assign var="userStateId" value=$delivadr->oxaddress__oxstateid->value}][{else}][{assign var="userStateId" value=null}][{/if}]
            [{if isset($deladr.oxaddress__oxstateid)}][{assign var="deliveryStateId" value=$deladr.oxaddress__oxstateid}][{else}][{assign var="deliveryStateId" value=null}][{/if}]
            <div class="col-lg-9">
                [{include file="form/fieldset/state.tpl"
                    countrySelectId="delCountrySelect"
                    stateSelectName="deladr[oxaddress__oxstateid]"
                    selectedStateIdPrim=$deliveryStateId
                    selectedStateId=$userStateId
                    class="form-control selectpicker"}]
                <div class="help-block"></div>
            </div>
        </div>
    [{/block}]
    [{if isset($aErrors.oxaddress__oxfon)}][{assign var="addressPhoneErrors" value=$aErrors.oxaddress__oxfon}][{else}][{assign var="addressPhoneErrors" value=null}][{/if}]
    <div class="form-group[{if $addressPhoneErrors}] oxInValid[{/if}]">
        <label class="control-label col-lg-3[{if $oView->isFieldRequired(oxaddress__oxfon)}] req[{/if}]">[{oxmultilang ident="PHONE"}]</label>
        <div class="col-lg-9">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxfon)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" size="37" maxlength="128" name="deladr[oxaddress__oxfon]" value="[{if isset( $deladr.oxaddress__oxfon )}][{$deladr.oxaddress__oxfon}][{elseif isset($delivadr->oxaddress__oxfon->value)}][{$delivadr->oxaddress__oxfon->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxfon)}] required=""[{/if}]>
            [{if $oView->isFieldRequired(oxaddress__oxfon)}]
                [{include file="message/inputvalidation.tpl" aErrors=$addressPhoneErrors}]
            [{/if}]
            <div class="help-block"></div>
        </div>
    </div>
    [{if isset($aErrors.oxaddress__oxfax)}][{assign var="addressFaxErrors" value=$aErrors.oxaddress__oxfax}][{else}][{assign var="addressFaxErrors" value=null}][{/if}]
    <div class="form-group[{if $addressFaxErrors}] oxInValid[{/if}]">
        <label class="control-label col-lg-3[{if $oView->isFieldRequired(oxaddress__oxfax)}] req[{/if}]">[{oxmultilang ident="FAX"}]</label>
        <div class="col-lg-9">
            <input class="form-control[{if $oView->isFieldRequired(oxaddress__oxfax)}] js-oxValidate js-oxValidate_notEmpty[{/if}]" type="text" size="37" maxlength="128" name="deladr[oxaddress__oxfax]" value="[{if isset( $deladr.oxaddress__oxfax )}][{$deladr.oxaddress__oxfax}][{elseif isset($delivadr->oxaddress__oxfax->value)}][{$delivadr->oxaddress__oxfax->value}][{/if}]"[{if $oView->isFieldRequired(oxaddress__oxfax)}] required=""[{/if}]>
            [{if $oView->isFieldRequired(oxaddress__oxfax)}]
                [{include file="message/inputvalidation.tpl" aErrors=$addressFaxErrors}]
            [{/if}]
            <div class="help-block"></div>
        </div>
    </div>
</div>
[{if !$noFormSubmit}]
    <div class="form-group">
        <div class="col-lg-offset-3 col-lg-9 col-xs-12">
            <p class="alert alert-info">[{oxmultilang ident="COMPLETE_MARKED_FIELDS"}]</p>
            <button id="accUserSaveBottom" type="submit" class="submitButton" name="save">[{oxmultilang ident="SAVE"}]</button>
        </div>
    </div>
[{/if}]
