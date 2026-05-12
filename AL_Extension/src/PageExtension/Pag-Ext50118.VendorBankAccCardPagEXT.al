PageExtension 50118 "Vendor Bank Acc Card_PagEXT" extends "Vendor Bank Account Card"
{

    layout
    {
        modify(Name)
        {
            Enabled = NameENABLED;
        }
        modify(Address)
        {
            Enabled = AddressENABLED;
        }
        modify("Address 2")
        {
            Enabled = "Address 2ENABLED";
        }
        modify("Bank Account No.")
        {
            Enabled = "Bank Account No.ENABLED";
        }
        modify(City)
        {
            Enabled = CityENABLED;
        }
        modify("Post Code")
        {
            Enabled = "Post CodeENABLED";
        }
        modify("Country/Region Code")
        {
            Enabled = "Country/Region CodeENABLED";
        }
        modify(IBAN)
        {
            Enabled = IBANENABLED;
        }
        modify("Phone No.")
        {
            Enabled = "Phone NoENABLED";
        }
        modify(Contact)
        {
            Enabled = ContactENABLED;
        }
        modify("Fax No.")
        {
            Enabled = "Fax NoENABLED";
        }
        modify("E-Mail")
        {
            Enabled = "E-MailENABLED";
        }
        modify("Home Page")
        {
            Enabled = "Home PageENABLED";
        }
        modify("SWIFT Code")
        {
            Enabled = "SWIFT CodeENABLED";
        }
        addafter("SWIFT Code")
        {
            field("Transit No."; Rec."Transit No.")
            {
                ApplicationArea = all;
                Enabled = "Transit NoENABLED";
            }
        }


        addafter("RIB Checked")
        {
            field("Default Bank Account"; rec."Default Bank Account")
            {
                ApplicationArea = all;
            }
            field(RIB; rec.RIB)
            {
                ApplicationArea = all;
            }
        }
        addafter(Transfer)
        {
            group(Localisation)
            {
                caption = 'Location';
                field("Balance Account No."; rec."Balance Account No.")
                {
                    ApplicationArea = all;
                }
                field("Invoice No. Length"; rec."Invoice No. Length")
                {
                    Enabled = "Invoice No. LengthENABLED";
                    ApplicationArea = all;
                }
                field("Invoice No. Startposition"; rec."Invoice No. Startposition")
                {
                    Enabled = "Invoice No. StartpositionENABLED";
                    ApplicationArea = all;
                }
                field("ESR Account No."; rec."ESR Account No.")
                {
                    Enabled = "ESR Account NoENABLED";
                    ApplicationArea = all;
                }
                field("ESR Type"; rec."ESR Type")
                {
                    Enabled = "ESR TypeENABLED";
                    ApplicationArea = all;
                }
                field("Giro Account No."; rec."Giro Account No.")
                {
                    Enabled = "Giro Account NoENABLED";
                    ApplicationArea = all;
                }
                field("Clearing No."; rec."Clearing No.")
                {
                    Enabled = "Clearing NoENABLED";
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        UpdateView;
                    end;
                }
                field("Payment Form"; rec."Payment Form")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;  // CH2300
                        UpdateView;
                    end;
                }
                field("Debit Bank"; rec."Debit Bank")
                {
                    ApplicationArea = all;
                }
                field("Bank Identifier Code"; rec."Bank Identifier Code")
                {
                    Enabled = "Bank Identifier CodeENABLED";
                    ApplicationArea = all;
                }
            }
        }

    }


    actions
    {

    }
    trigger OnOpenPage()
    BEGIN

        //+CH+2300
        gGlSetup.GET;
        UpdateView;
        //+CH+2300//
    END;

    trigger OnAfterGetRecord()
    BEGIN

        rec.SETRANGE(Code);
        //+CH+2300
        UpdateView;
        //+CH+2300//
    END;

    trigger OnNewRecord(BelowxRec: Boolean)
    BEGIN

        //+CH+2300
        UpdateView;
        //+CH+2300//
    END;

    PROCEDURE UpdateView();
    BEGIN

        CASE gGlSetup.Localization OF
            gGlSetup.Localization::CH:
                BEGIN
                    //+CH+
                    "Clearing NoENABLED" := (FALSE);
                    "Bank Account No.ENABLED" := (FALSE);
                    "ESR TypeENABLED" := (FALSE);
                    "Giro Account NoENABLED" := (FALSE);
                    "ESR Account NoENABLED" := (FALSE);
                    "Invoice No. StartpositionENABLED" := (FALSE);
                    "Invoice No. LengthENABLED" := (FALSE);
                    NameENABLED := (FALSE);
                    AddressENABLED := (FALSE);
                    "Address 2ENABLED" := (FALSE);
                    "Post CodeENABLED" := (FALSE);
                    CityENABLED := (FALSE);
                    "Bank Identifier CodeENABLED" := (FALSE);
                    IBANENABLED := (FALSE);
                    // CH2300.begin
                    "Country/Region CodeENABLED" := (FALSE);
                    "Phone NoENABLED" := (FALSE);
                    ContactENABLED := (FALSE);
                    "Fax NoENABLED" := (FALSE);
                    "E-MailENABLED" := (FALSE);
                    "Home PageENABLED" := (FALSE);
                    "SWIFT CodeENABLED" := (FALSE);
                    "Transit NoENABLED" := (FALSE);

                    CASE rec."Payment Form" OF
                        rec."Payment Form"::ESR,
                         rec."Payment Form"::"ESR+":
                            BEGIN
                                "ESR TypeENABLED" := (TRUE);
                                "ESR Account NoENABLED" := (TRUE);
                                "Invoice No. StartpositionENABLED" := (TRUE);
                                "Invoice No. LengthENABLED" := (TRUE);
                            END;

                        rec."Payment Form"::"Post Payment Domestic":
                            BEGIN
                                "Giro Account NoENABLED" := (TRUE);
                                "Bank Account No.ENABLED" := (TRUE);
                                NameENABLED := (FALSE);
                                AddressENABLED := (FALSE);
                                "Address 2ENABLED" := (FALSE);
                                "Post CodeENABLED" := (FALSE);
                                CityENABLED := (FALSE);

                                "Country/Region CodeENABLED" := (FALSE);
                                "Phone NoENABLED" := (TRUE);
                                ContactENABLED := (TRUE);
                                "Fax NoENABLED" := (TRUE);
                                "E-MailENABLED" := (TRUE);
                                "Home PageENABLED" := (TRUE);
                            END;

                        rec."Payment Form"::"Bank Payment Domestic":
                            BEGIN
                                "Clearing NoENABLED" := (TRUE);
                                NameENABLED := (TRUE);
                                AddressENABLED := (TRUE);
                                "Address 2ENABLED" := (TRUE);
                                "Post CodeENABLED" := (TRUE);
                                CityENABLED := (TRUE);
                                "Bank Account No.ENABLED" := (TRUE);

                                IBANCheck;   // CH2301

                                "Country/Region CodeENABLED" := (TRUE);
                                "Phone NoENABLED" := (TRUE);
                                ContactENABLED := (TRUE);
                                "Fax NoENABLED" := (TRUE);
                                "E-MailENABLED" := (TRUE);
                                "Home PageENABLED" := (TRUE);

                            END;

                        rec."Payment Form"::"Cash Outpayment Order Domestic":
                            ;

                        rec."Payment Form"::"Post Payment Abroad":
                            BEGIN
                                "Bank Account No.ENABLED" := (TRUE);

                                IBANCheck;   // CH2301
                            END;

                        rec."Payment Form"::"Bank Payment Abroad":
                            BEGIN
                                "Bank Identifier CodeENABLED" := (TRUE);
                                NameENABLED := (TRUE);
                                AddressENABLED := (TRUE);
                                "Address 2ENABLED" := (TRUE);
                                "Post CodeENABLED" := (TRUE);
                                CityENABLED := (TRUE);
                                "Bank Account No.ENABLED" := (TRUE);

                                IBANCheck;  // CH2301

                                "Country/Region CodeENABLED" := (TRUE);
                                "Phone NoENABLED" := (TRUE);
                                ContactENABLED := (TRUE);
                                "Fax NoENABLED" := (TRUE);
                                "E-MailENABLED" := (TRUE);
                                "Home PageENABLED" := (TRUE);

                            END;

                        rec."Payment Form"::"SWIFT Payment Abroad":
                            BEGIN
                                "SWIFT CodeENABLED" := (TRUE);
                                // CH2302.BEGIN
                                NameENABLED := (TRUE);
                                AddressENABLED := (TRUE);
                                "Post CodeENABLED" := (TRUE);
                                CityENABLED := (TRUE);
                                "Country/Region CodeENABLED" := (TRUE);
                                // CH2302.END
                                "Bank Account No.ENABLED" := (TRUE);

                                IBANCheck;  // CH2301
                            END;

                        rec."Payment Form"::"Cash Outpayment Order Abroad":
                            ;
                    END;
                END;
            // CH2300.end
            //+CH+
            ELSE
                frmCHVISIBLE := (FALSE)
        END;
    end;

    LOCAL PROCEDURE IBANCheck();
    begin

        // CH2301.begin
        IBANENABLED := (TRUE);
        IF rec.IBAN <> '' THEN
            "Bank Account No.ENABLED" := (FALSE);
        IF rec."Bank Account No." <> '' THEN
            IBANENABLED := (FALSE);
        // CH2301.end

    end;

    VAR
        Mail: Codeunit Mail;
        gGlSetup: Record "General Ledger Setup";
        //GL2024
        IBANENABLED: boolean;
        "Bank Account No.ENABLED": boolean;
        "Clearing NoENABLED": boolean;



        "ESR TypeENABLED": boolean;
        "Giro Account NoENABLED": boolean;
        "ESR Account NoENABLED": boolean;
        "Invoice No. StartpositionENABLED": boolean;
        "Invoice No. LengthENABLED": boolean;
        NameENABLED: boolean;
        AddressENABLED: boolean;
        "Address 2ENABLED": boolean;
        "Post CodeENABLED": boolean;
        CityENABLED: boolean;
        "Bank Identifier CodeENABLED": boolean;
        "Country/Region CodeENABLED": boolean;
        "Phone NoENABLED": boolean;
        ContactENABLED: boolean;
        "Fax NoENABLED": boolean;
        "E-MailENABLED": boolean;
        "Home PageENABLED": boolean;
        "SWIFT CodeENABLED": boolean;
        "Transit NoENABLED": boolean;
        frmCHVISIBLE: boolean;


}
