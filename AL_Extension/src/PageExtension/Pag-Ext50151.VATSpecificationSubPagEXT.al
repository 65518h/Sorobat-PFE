PageExtension 50151 "VAT Specification Sub_PagEXT" extends "VAT Specification Subform"
{

    layout
    {
        modify("Inv. Disc. Base Amount")
        {
            Visible = true;
        }
        modify("Invoice Discount Amount")
        {
            Editable = "Invoice Discount AmountEDITABLE";
            Visible = true;
        }
        modify("VAT Base")
        {
            //GL2024  AutoFormatExpression = CurrencyCode;

            Editable = "VAT BaseEDITABLE";
        }

        modify("Amount Including VAT")
        {
            Editable = "Amount Including VATEDITABLE";
        }
        modify("VAT %")
        {
            Editable = "VAT %EDITABLE";
        }
        modify("Line Amount")
        {
            Editable = "Line AmountEDITABLE";
        }



    }
    actions
    {

    }
    PROCEDURE SetAllowModifyVAT();
    BEGIN

        //#5836
        AllowVATDifFromF9 := TRUE;
        AllowVATDifferenceOnThisTab := TRUE;
        //#5836//
    END;

    PROCEDURE SetEditableFields();
    BEGIN

        //#5836
        IF AllowVATDifFromF9 THEN BEGIN
            "Amount Including VATEDITABLE" := (FALSE);
            "VAT BaseEDITABLE" := (FALSE);
            "Invoice Discount AmountEDITABLE" := (FALSE);
            "VAT %EDITABLE" := (FALSE);
            "Line AmountEDITABLE" := (FALSE);
        END;
        //#5836//

    END;

    var
        AllowVATDifFromF: Boolean;
        AllowVATDifFromF9: Boolean;
        AllowVATDifferenceOnThisTab: Boolean;
        //GL2024
        "VAT BaseEDITABLE": Boolean;
        "Invoice Discount AmountEDITABLE": Boolean;
        "Amount Including VATEDITABLE": Boolean;
        "VAT %EDITABLE": Boolean;
        "Line AmountEDITABLE": Boolean;
}