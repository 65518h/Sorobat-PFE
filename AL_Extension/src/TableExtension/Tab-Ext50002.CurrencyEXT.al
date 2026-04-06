TableExtension 50002 CurrencyEXT extends Currency
{
    fields
    {
        modify("Cust. Ledg. Entries in Filter")
        {
            Caption = 'Cust. Ledg. Entries in Filter';
        }
        modify("Vendor Ledg. Entries in Filter")
        {
            Caption = 'Vendor Ledg. Entries in Filter';
        }



        modify("Unit-Amount Rounding Precision")
        {
            trigger OnAfterValidate()
            var
            begin
                //#6700
                IF "Sales Unit-Amt Round. Prec." <> 0 THEN
                    "Sales Unit-Amt Round. Prec." := ROUND("Sales Unit-Amt Round. Prec.", "Unit-Amount Rounding Precision");
                //#6700//

            end;
        }

        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';

        }
        field(8003900; "Sales Unit-Amt Round. Prec."; Decimal)
        {
            Caption = 'Sales Unit-Amt Round. Prec.';
            DecimalPlaces = 0 : 9;
            InitValue = 0.00001;
        }
    }
    keys
    {
        key(STG_Key2; Synchronise)
        {
        }
    }
    //GL2024
    //il n'y a pas d'event "On Before" la procédure InitRoundingPrecision
    /*//PERF
      //GLSetup.GET;
      lSingleInstance.wGetGLAccount(GLSetup);
      INIT;
      //PERF//*/


}

