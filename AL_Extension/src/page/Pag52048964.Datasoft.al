Page 52048964 Datasoft
{//GL2024  ID dans Nav 2009 : "39004675"
    Caption = 'DATASOFT- Business Solution Partner';
    PageType = Card;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            label(Control100000001)
            {
                ApplicationArea = Basic;
                Caption = 'DATASOFT TUNISIE';
                Style = Favorable;

            }
            label(Control1000000002)
            {
                ApplicationArea = Basic;
                Caption = 'Adresse : 29, Av de l''Indépendance - Résidence Mériam';
            }
            label(Control1000000003)
            {
                ApplicationArea = Basic;
                Caption = '           B 416 - 2080 Ariana - Tunisie';
            }
            label(Control1000000004)
            {
                ApplicationArea = Basic;
                Caption = 'Tel : 216 71 72 35 62';
            }
            label(Control1000000005)
            {
                ApplicationArea = Basic;
                Caption = 'Fax : 216 71 71 26 53';
            }
            label(Control1000000006)
            {
                ApplicationArea = Basic;
                Caption = 'Email : Datasoft@Gnet.tn';
            }
            label(Control1000000007)
            {
                ApplicationArea = Basic;
                Caption = 'www.datasoft.fr/tunisie';
            }
            label(Control10000000071)
            {
                ApplicationArea = Basic;
                Caption = '';
            }
            label(Control1000000072)
            {
                ApplicationArea = Basic;
                Caption = '';
            }


            label(Control1000000008)
            {
                ApplicationArea = Basic;
                Caption = 'Microsoft';
                Style = Standard;
            }
            label(Control1000000009)
            {
                ApplicationArea = Basic;
                Caption = '  CERTIFIED';
                Style = AttentionAccent;
            }
            label(Control1000000010)
            {
                ApplicationArea = Basic;
                Caption = 'Business Solution';
                Style = AttentionAccent;

            }
            label(Control1000000011)
            {
                ApplicationArea = Basic;
                Caption = 'Partner';
                Style = AttentionAccent;

            }

        }
    }

    actions
    {
    }

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        FAJnlManagement: Codeunit FAJnlManagement;
        InsuranceJnlManagement: Codeunit InsuranceJnlManagement;
        FAReclassJnlManagement: Codeunit FAReclassJnlManagement;
        Mail: Codeunit Mail;
        Text19009177: label 'B 416 - 2080 Ariana - Tunisie';
        Text19048129: label 'Partner';
}

