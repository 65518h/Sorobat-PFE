Codeunit 50005 "Montant Toute Lettre"
{

    trigger OnRun()
    begin
    end;

    var
        milliard: Text[250];

        million: Text[250];
        mille: Text[250];
        cent: Text[250];
        entiere: Decimal;
        decimal: Integer;
        nbre: Decimal;
        nbre1: Decimal;
        j: Integer;
        "Chèque": Report Check;
        chaine1: Text[30];
        VarDeviseEntiere: Text[30];
        VarDeviseDecimal: Text[30];


    procedure "Montant en texte"(var strprix: Text[1024]; prix: Decimal)
    begin
        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 1000, 1, '=');
        nbre := entiere;
        million := '';
        mille := '';
        cent := '';
        nbre1 := nbre DIV 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;
        nbre := nbre MOD 1000000;
        nbre1 := nbre DIV 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre MOD 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' FCFA';
        if entiere = 1 then
            strprix := strprix + ' FCFA';

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UpperCase(strprix);
    end;


    procedure Centaine(var chaine: Text[250]; i: Integer)
    var
        k: Integer;
    begin
        k := i DIV 100;
        chaine := '';
        case k of
            1:
                chaine := 'cent';
            2:
                chaine := 'deux cent';
            3:
                chaine := 'trois cent';
            4:
                chaine := 'quatre cent';
            5:
                chaine := 'cinq cent';
            6:
                chaine := 'six cent';
            7:
                chaine := 'sept cent';
            8:
                chaine := 'huit cent';
            9:
                chaine := 'neuf cent';
        end;
        k := i MOD 100;
        Dizaine(chaine, k);
    end;


    procedure Dizaine(var chaine: Text[250]; i: Integer)
    var
        k: Integer;
        l: Integer;
    begin
        if i > 16 then begin
            k := i DIV 10;
            chaine1 := '';
            case k of
                1:
                    chaine1 := 'dix';
                2:
                    chaine1 := 'vingt';
                3:
                    chaine1 := 'trente';
                4:
                    chaine1 := 'quarante';
                5:
                    chaine1 := 'cinquante';
                6:
                    chaine1 := 'soixante';
                7:
                    chaine1 := 'soixante';
                8:
                    chaine1 := 'quatre vingt';
                9:
                    chaine1 := 'quatre vingt';
            end;
            if ((chaine1 <> '') and (chaine <> '')) then
                chaine1 := ' ' + chaine1;
            chaine := chaine + chaine1;
            l := k;
            if ((k = 7) or (k = 9)) then
                k := (i MOD 10) + 10
            else
                k := (i MOD 10);
        end
        else
            k := i;

        if ((l <> 8) and (l <> 0) and ((k = 1) or (k = 11))) then
            chaine := chaine + ' et';
        if (((k = 0) or (k > 16)) and ((l = 7) or (l = 9))) then begin
            chaine := chaine + ' dix';
            if k > 16 then
                k := k - 10;
        end;

        Unité(chaine, k);
    end;


    procedure "Unité"(var chaine: Text[250]; i: Integer)
    begin
        chaine1 := '';
        case i of
            1:
                chaine1 := 'un';
            2:
                chaine1 := 'deux';
            3:
                chaine1 := 'trois';
            4:
                chaine1 := 'quatre';
            5:
                chaine1 := 'cinq';
            6:
                chaine1 := 'six';
            7:
                chaine1 := 'sept';
            8:
                chaine1 := 'huit';
            9:
                chaine1 := 'neuf';
            10:
                chaine1 := 'dix';
            11:
                chaine1 := 'onze';
            12:
                chaine1 := 'douze';
            13:
                chaine1 := 'treize';
            14:
                chaine1 := 'quatorze';
            15:
                chaine1 := 'quinze';
            16:
                chaine1 := 'seize';
        end;
        if ((chaine1 <> '') and (chaine <> '')) then
            chaine1 := ' ' + chaine1;
        chaine := chaine + chaine1;
    end;


    procedure "Montant en texte sans millimes"(var strprix: Text[250]; prix: Decimal)
    begin
        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 1000, 1, '<');
        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);
        milliard := '';
        million := '';
        mille := '';
        cent := '';
        //HS
        nbre1 := nbre DIV 1000000000;
        if nbre1 <> 0 then begin
            Centaine(milliard, nbre1);
            milliard := milliard + ' milliard';
        end;
        //HS
        nbre := nbre MOD 1000000000;
        nbre1 := nbre DIV 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre MOD 1000000;
        nbre1 := nbre DIV 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre MOD 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;
        //HS
        if milliard <> '' then
            strprix := milliard;

        if million <> '' then
            if strprix <> '' then
                strprix := strprix + ' ' + million
            else
                strprix := million;
        //HS

        // HS if million <> '' then
        //     strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' FCFA';
        if entiere = 1 then
            strprix := strprix + ' FCFA';

        if decimal <> 0 then begin
            if strprix <> '' then
                strprix := strprix + ' ' + Format(decimal)
            else
                strprix := strprix + Format(decimal);
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UpperCase(strprix);
    end;


    procedure "Montant en texteDevise"(var strprix: Text[250]; prix: Decimal; Devise: Text[30])
    begin
        QuelleDevise(Devise, 0);
        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 100, 1, '<');
        nbre := entiere;

        milliard := '';
        million := '';
        mille := '';
        cent := '';

        //HS
        nbre1 := nbre DIV 1000000000;
        if nbre1 <> 0 then begin
            Centaine(milliard, nbre1);
            milliard := milliard + ' milliard';
        end;
        //HS

        nbre1 := nbre DIV 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;
        nbre := nbre MOD 1000000;
        nbre1 := nbre DIV 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre MOD 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;


        //HS
        if milliard <> '' then
            strprix := milliard;

        if million <> '' then
            if strprix <> '' then
                strprix := strprix + ' ' + million
            else
                strprix := million;
        //HS

        // HS if million <> '' then
        //     strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;
        if entiere = 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' ' + VarDeviseDecimal
            else
                strprix := strprix + ' ' + VarDeviseDecimal;



        end;

        strprix := UpperCase(strprix);
    end;


    procedure QuelleDevise(var StrDevise: Text[30]; lng: Integer)
    begin

        if StrDevise = 'USD' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'US Dollars';
                        VarDeviseDecimal := 'Cents';
                    end;
                else begin
                    VarDeviseEntiere := 'Dollars US';
                    VarDeviseDecimal := 'Cents';
                end;
            end;

        if StrDevise = 'EURO' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Euro';
                        VarDeviseDecimal := 'EuroCents';
                    end;
                else begin
                    VarDeviseEntiere := 'Euro';
                    VarDeviseDecimal := 'Centimes';
                end;
            end;

        if StrDevise = '£' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Pounds';
                        VarDeviseDecimal := 'Cents';
                    end;
                else begin
                    VarDeviseEntiere := 'Livres Sterling';
                    VarDeviseDecimal := 'Cents';
                end;
            end;
    end;


    procedure MontantTexteLangue(var strprix: Text[250]; prix: Decimal; lng: Integer)
    begin
        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 1000, 1, '<');
        nbre := entiere;
        million := '';
        mille := '';
        cent := '';
        nbre1 := nbre DIV 1000000;
        if nbre1 <> 0 then begin
            CentaineLangue(million, nbre1, lng);
            case lng of
                1033:
                    million := million + ' million';
                else
                    million := million + ' million';
            end;
        end;

        nbre := nbre MOD 1000000;
        nbre1 := nbre DIV 1000;
        if nbre1 <> 0 then begin
            CentaineLangue(mille, nbre1, lng);
            if mille <> 'un' then
                case lng of
                    1033:
                        mille := mille + ' thousand';
                    else
                        mille := mille + ' mille';
                end
            else
                mille := 'mille'
        end;

        nbre := nbre MOD 1000;

        if nbre <> 0 then begin
            CentaineLangue(cent, nbre, lng);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' FCFA';
        if entiere = 1 then
            strprix := strprix + ' FCFA';

        cent := '';
        if decimal <> 0 then begin
            CentaineLangue(cent, decimal, lng);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' millime'
            else
                strprix := strprix + ' millimes';
        end;

        strprix := UpperCase(strprix);
    end;


    procedure MontantTexteDeviseLangue(var strprix: Text[250]; prix: Decimal; Devise: Text[30]; lng: Integer)
    begin
        QuelleDevise(Devise, lng);
        entiere := ROUND(prix, 1, '<');
        decimal := ROUND((prix - entiere) * 100, 1, '<');

        nbre := entiere;
        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre DIV 1000000;
        if nbre1 <> 0 then begin
            CentaineLangue(million, nbre1, lng);
            case lng of
                1033:
                    million := million + ' million';
                else
                    million := million + ' million';
            end;
        end;

        nbre := nbre MOD 1000000;
        nbre1 := nbre DIV 1000;
        if nbre1 <> 0 then begin
            CentaineLangue(mille, nbre1, lng);
            if mille <> 'un' then
                case lng of
                    1033:
                        mille := mille + ' thousand';
                    else
                        mille := mille + ' mille';
                end
            else
                mille := 'mille'
        end;

        nbre := nbre MOD 1000;

        if nbre <> 0 then begin
            CentaineLangue(cent, nbre, lng);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;
        if entiere = 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;

        cent := '';
        if decimal <> 0 then begin
            CentaineLangue(cent, decimal, lng);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' ' + VarDeviseDecimal
            else
                strprix := strprix + ' ' + VarDeviseDecimal;



        end;

        strprix := UpperCase(strprix);
    end;


    procedure CentaineLangue(var chaine: Text[250]; i: Integer; lng: Integer)
    var
        k: Integer;
    begin
        k := i DIV 100;
        chaine := '';
        case lng of
            1033:
                begin
                    case k of
                        1:
                            chaine := 'one hundred';
                        2:
                            chaine := 'two hundred';
                        3:
                            chaine := 'three hundred';
                        4:
                            chaine := 'four hundred';
                        5:
                            chaine := 'five hundred';
                        6:
                            chaine := 'six hundred';
                        7:
                            chaine := 'seven hundred';
                        8:
                            chaine := 'height hundred';
                        9:
                            chaine := 'nine hundred';
                    end;
                end;
            else begin
                case k of
                    1:
                        chaine := 'cent';
                    2:
                        chaine := 'deux cent';
                    3:
                        chaine := 'trois cent';
                    4:
                        chaine := 'quatre cent';
                    5:
                        chaine := 'cinq cent';
                    6:
                        chaine := 'six cent';
                    7:
                        chaine := 'sept cent';
                    8:
                        chaine := 'huit cent';
                    9:
                        chaine := 'neuf cent';
                end;
            end;
        end;
        k := i MOD 100;
        DizaineLangue(chaine, k, lng);
    end;


    procedure DizaineLangue(var chaine: Text[250]; i: Integer; lng: Integer)
    var
        k: Integer;
        l: Integer;
    begin
        case lng of
            1033:
                begin
                    if i > 19 then begin
                        k := i DIV 10;
                        chaine1 := '';
                        case k of
                            1:
                                chaine1 := 'ten';
                            2:
                                chaine1 := 'twenty';
                            3:
                                chaine1 := 'thirty';
                            4:
                                chaine1 := 'fourty';
                            5:
                                chaine1 := 'fivety';
                            6:
                                chaine1 := 'sixty';
                            7:
                                chaine1 := 'seventy';
                            8:
                                chaine1 := 'heighty';
                            9:
                                chaine1 := 'ninety';
                        end;
                        if ((chaine1 <> '') and (chaine <> '')) then
                            chaine1 := ' ' + chaine1;
                        chaine := chaine + chaine1;
                        l := k;
                        k := (i MOD 10);
                    end
                    else
                        k := i;

                    if ((l <> 8) and (l <> 0) and ((k = 11) or (k = 11))) then
                        chaine := chaine + ' and';
                    if (((k = 0) or (k > 19)) and ((l = 7) or (l = 9))) then begin
                        chaine := chaine + ' dix';
                        if k > 19 then
                            k := k - 10;
                    end;
                end;
            else begin
                if i > 16 then begin
                    k := i DIV 10;
                    chaine1 := '';
                    case k of
                        1:
                            chaine1 := 'dix';
                        2:
                            chaine1 := 'vingt';
                        3:
                            chaine1 := 'trente';
                        4:
                            chaine1 := 'quarante';
                        5:
                            chaine1 := 'cinquante';
                        6:
                            chaine1 := 'soixante';
                        7:
                            chaine1 := 'soixante';
                        8:
                            chaine1 := 'quatre vingt';
                        9:
                            chaine1 := 'quatre vingt';
                    end;
                    if ((chaine1 <> '') and (chaine <> '')) then
                        chaine1 := ' ' + chaine1;
                    chaine := chaine + chaine1;
                    l := k;
                    if ((k = 7) or (k = 9)) then
                        k := (i MOD 10) + 10
                    else
                        k := (i MOD 10);
                end
                else
                    k := i;

                if ((l <> 8) and (l <> 0) and ((k = 1) or (k = 11))) then
                    chaine := chaine + ' et';
                if (((k = 0) or (k > 16)) and ((l = 7) or (l = 9))) then begin
                    chaine := chaine + ' dix';
                    if k > 16 then
                        k := k - 10;
                end;
            end;
        end;
        UnitéLangue(chaine, k, lng);
    end;


    procedure "UnitéLangue"(var chaine: Text[250]; i: Integer; lng: Integer)
    begin
        chaine1 := '';
        case lng of
            1033:
                case i of
                    1:
                        chaine1 := 'one';
                    2:
                        chaine1 := 'two';
                    3:
                        chaine1 := 'three';
                    4:
                        chaine1 := 'four';
                    5:
                        chaine1 := 'five';
                    6:
                        chaine1 := 'six';
                    7:
                        chaine1 := 'seven';
                    8:
                        chaine1 := 'height';
                    9:
                        chaine1 := 'nine';
                    10:
                        chaine1 := 'ten';
                    11:
                        chaine1 := 'eleven';
                    12:
                        chaine1 := 'twelve';
                    13:
                        chaine1 := 'thirteen';
                    14:
                        chaine1 := 'fourteen';
                    15:
                        chaine1 := 'fifteen';
                    16:
                        chaine1 := 'sixteen';
                    17:
                        chaine1 := 'seventeen';
                    18:
                        chaine1 := 'heighteen';
                    19:
                        chaine1 := 'ninteen';
                end;
            else
                case i of
                    1:
                        chaine1 := 'un';
                    2:
                        chaine1 := 'deux';
                    3:
                        chaine1 := 'trois';
                    4:
                        chaine1 := 'quatre';
                    5:
                        chaine1 := 'cinq';
                    6:
                        chaine1 := 'six';
                    7:
                        chaine1 := 'sept';
                    8:
                        chaine1 := 'huit';
                    9:
                        chaine1 := 'neuf';
                    10:
                        chaine1 := 'dix';
                    11:
                        chaine1 := 'onze';
                    12:
                        chaine1 := 'douze';
                    13:
                        chaine1 := 'treize';
                    14:
                        chaine1 := 'quatorze';
                    15:
                        chaine1 := 'quinze';
                    16:
                        chaine1 := 'seize';
                end;
        end;
        if ((chaine1 <> '') and (chaine <> '')) then
            chaine1 := ' ' + chaine1;
        chaine := chaine + chaine1;
    end;
}

