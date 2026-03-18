Table 8004014 "Prepay Export Setup"
{
    // //PREPAIE GESWAY 01/01/02 Paramètres interface Sage 500
    //                           Ajout du type des cumuls libres (quantité ou montant)

    Caption = 'Prepay Export Setup';

    fields
    {
        field(1; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        field(2; "Hour Of Absence 1"; Code[12])
        {
            Caption = 'Hour Of Absence 1';
            TableRelation = "Prepay Reason Code";
        }
        field(3; "Hour Of Absence 2"; Code[12])
        {
            Caption = 'Hour Of Absence 2';
            TableRelation = "Prepay Reason Code";
        }
        field(4; "Hour Of Absence 3"; Code[12])
        {
            Caption = 'Hour Of Absence 3';
            TableRelation = "Prepay Reason Code";
        }
        field(5; "Hour Of Absence 4"; Code[12])
        {
            Caption = 'Hour Of Absence 4';
            TableRelation = "Prepay Reason Code";
        }
        field(6; "Hour Of Absence 5"; Code[12])
        {
            Caption = 'Hour Of Absence 5';
            TableRelation = "Prepay Reason Code";
        }
        field(7; "Hour Of Absence 6"; Code[12])
        {
            Caption = 'Hour Of Absence 6';
            TableRelation = "Prepay Reason Code";
        }
        field(8; "Hour Of Absence 7"; Code[12])
        {
            Caption = 'Hour Of Absence 7';
            TableRelation = "Prepay Reason Code";
        }
        field(9; "Hour Of Absence 8"; Code[12])
        {
            Caption = 'Hour Of Absence 8';
            TableRelation = "Prepay Reason Code";
        }
        field(10; "Hour Of Absence 9"; Code[12])
        {
            Caption = 'Hour Of Absence 9';
            TableRelation = "Prepay Reason Code";
        }
        field(11; "Hour Of Absence 10"; Code[12])
        {
            Caption = 'Hour Of Absence 10';
            TableRelation = "Prepay Reason Code";
        }
        field(12; "Overtime 1"; Code[12])
        {
            Caption = 'Overtime 1';
            TableRelation = "Prepay Reason Code";
        }
        field(13; "Overtime 2"; Code[12])
        {
            Caption = 'Overtime 2';
            TableRelation = "Prepay Reason Code";
        }
        field(14; "Overtime 3"; Code[12])
        {
            Caption = 'Overtime 3';
            TableRelation = "Prepay Reason Code";
        }
        field(15; "Overtime 4"; Code[12])
        {
            Caption = 'Overtime 4';
            TableRelation = "Prepay Reason Code";
        }
        field(16; "Overtime 5"; Code[12])
        {
            Caption = 'Overtime 5';
            TableRelation = "Prepay Reason Code";
        }
        field(17; "Overtime 6"; Code[12])
        {
            Caption = 'Overtime 6';
            TableRelation = "Prepay Reason Code";
        }
        field(18; "Overtime 7"; Code[12])
        {
            Caption = 'Overtime 7';
            TableRelation = "Prepay Reason Code";
        }
        field(19; "Overtime 8"; Code[12])
        {
            Caption = 'Overtime 8';
            TableRelation = "Prepay Reason Code";
        }
        field(20; "Overtime 9"; Code[12])
        {
            Caption = 'Overtime 9';
            TableRelation = "Prepay Reason Code";
        }
        field(21; "Overtime 10"; Code[12])
        {
            Caption = 'Overtime 10';
            TableRelation = "Prepay Reason Code";
        }
        field(22; "Complementary Hours 1"; Code[12])
        {
            Caption = 'Complementary Hours 1';
            TableRelation = "Prepay Reason Code";
        }
        field(23; "Complementary Hours 2"; Code[12])
        {
            Caption = 'Complementary Hours 2';
            TableRelation = "Prepay Reason Code";
        }
        field(24; "Free office plurality 1"; Code[12])
        {
            Caption = 'Free office plurality 1';
            TableRelation = "Prepay Reason Code";
        }
        field(25; "Free office plurality 2"; Code[12])
        {
            Caption = 'Free office plurality 2';
            TableRelation = "Prepay Reason Code";
        }
        field(26; "Free office plurality 3"; Code[12])
        {
            Caption = 'Free office plurality 3';
            TableRelation = "Prepay Reason Code";
        }
        field(27; "Free office plurality 4"; Code[12])
        {
            Caption = 'Free office plurality 4';
            TableRelation = "Prepay Reason Code";
        }
        field(28; "Free office plurality 5"; Code[12])
        {
            Caption = 'Free office plurality 5';
            TableRelation = "Prepay Reason Code";
        }
        field(29; "Free office plurality 6"; Code[12])
        {
            Caption = 'Free office plurality 6';
            TableRelation = "Prepay Reason Code";
        }
        field(30; "Free office plurality 7"; Code[12])
        {
            Caption = 'Free office plurality 7';
            TableRelation = "Prepay Reason Code";
        }
        field(31; "Free office plurality 8"; Code[12])
        {
            Caption = 'Free office plurality 8';
            TableRelation = "Prepay Reason Code";
        }
        field(32; "Free office plurality 9"; Code[12])
        {
            Caption = 'Free office plurality 9';
            TableRelation = "Prepay Reason Code";
        }
        field(33; "Free office plurality 10"; Code[12])
        {
            Caption = 'Free office plurality 10';
            TableRelation = "Prepay Reason Code";
        }
        field(34; "Constant presence"; Code[12])
        {
            Caption = 'Constant presence';
            TableRelation = "Prepay Reason Code";
        }
        field(35; "Constant Ceiling"; Code[12])
        {
            Caption = 'Constant Ceiling';
            TableRelation = "Prepay Reason Code";
        }
        field(36; "Constant Floor"; Code[12])
        {
            Caption = 'Constant Floor';
            TableRelation = "Prepay Reason Code";
        }
        field(37; "Constant 30th"; Code[12])
        {
            Caption = 'Constant 30th';
            TableRelation = "Prepay Reason Code";
        }
        field(38; "Vacation Taken"; Code[12])
        {
            Caption = 'Vacation Taken';
            TableRelation = "Prepay Reason Code";
        }
        field(39; "Acquired Vacation"; Code[12])
        {
            Caption = 'Acquired Vacation';
            TableRelation = "Prepay Reason Code";
        }
        field(40; "Right additional leave"; Code[12])
        {
            Caption = 'Right additional leave';
            TableRelation = "Prepay Reason Code";
        }
        field(41; "Numbre of Saturday Taken"; Code[12])
        {
            Caption = 'Numbre of Saturday Taken';
            TableRelation = "Prepay Reason Code";
        }
        field(42; "Acquired rest"; Code[12])
        {
            Caption = 'Acquired rest';
            TableRelation = "Prepay Reason Code";
        }
        field(43; "Rest taken"; Code[12])
        {
            Caption = 'Rest taken';
            TableRelation = "Prepay Reason Code";
        }
        field(44; "Vacation Starting Date 1"; Date)
        {
            Caption = 'Vacation Starting Date 1';
        }
        field(45; "Vacation End Date 1"; Date)
        {
            Caption = 'Vacation End Date 1';
        }
        field(46; "Vacation Starting Date 2"; Date)
        {
            Caption = 'Vacation Starting Date 2';
        }
        field(47; "Vacation End Date 2"; Date)
        {
            Caption = 'Vacation End Date 2';
        }
        field(48; "Vacation Starting Date 3"; Date)
        {
            Caption = 'Vacation Starting Date 3';
        }
        field(49; "Vacation End Date 3"; Date)
        {
            Caption = 'Vacation End Date 3';
        }
        field(50; "Comment 1"; Text[60])
        {
            Caption = 'Comment 1';
        }
        field(51; "Comment 2"; Text[60])
        {
            Caption = 'Comment 2';
        }
        field(52; "Free office plurality 11"; Code[12])
        {
            Caption = 'Free office plurality 11';
            TableRelation = "Prepay Reason Code";
        }
        field(53; "Free office plurality 12"; Code[12])
        {
            Caption = 'Free office plurality 12';
            TableRelation = "Prepay Reason Code";
        }
        field(54; "Free office plurality 13"; Code[12])
        {
            Caption = 'Free office plurality 13';
            TableRelation = "Prepay Reason Code";
        }
        field(55; "Free office plurality 14"; Code[12])
        {
            Caption = 'Free office plurality 14';
            TableRelation = "Prepay Reason Code";
        }
        field(56; "Free office plurality 15"; Code[12])
        {
            Caption = 'Free office plurality 15';
            TableRelation = "Prepay Reason Code";
        }
        field(57; "Free office plurality 16"; Code[12])
        {
            Caption = 'Free office plurality 16';
            TableRelation = "Prepay Reason Code";
        }
        field(58; "Free office plurality 17"; Code[12])
        {
            Caption = 'Free office plurality 17';
            TableRelation = "Prepay Reason Code";
        }
        field(59; "Free office plurality 18"; Code[12])
        {
            Caption = 'Free office plurality 18';
            TableRelation = "Prepay Reason Code";
        }
        field(60; "Free office plurality 19"; Code[12])
        {
            Caption = 'Free office plurality 19';
            TableRelation = "Prepay Reason Code";
        }
        field(61; "Free office plurality 20"; Code[12])
        {
            Caption = 'Free office plurality 20';
            TableRelation = "Prepay Reason Code";
        }
        field(62; "Free office plurality 21"; Code[12])
        {
            Caption = 'Free office plurality 21';
            TableRelation = "Prepay Reason Code";
        }
        field(63; "Free office plurality 22"; Code[12])
        {
            Caption = 'Free office plurality 22';
            TableRelation = "Prepay Reason Code";
        }
        field(64; "Free office plurality 23"; Code[12])
        {
            Caption = 'Free office plurality 23';
            TableRelation = "Prepay Reason Code";
        }
        field(65; "Free office plurality 24"; Code[12])
        {
            Caption = 'Free office plurality 24';
            TableRelation = "Prepay Reason Code";
        }
        field(66; "Free office plurality 25"; Code[12])
        {
            Caption = 'Free office plurality 25';
            TableRelation = "Prepay Reason Code";
        }
        field(67; "Free office plurality 26"; Code[12])
        {
            Caption = 'Free office plurality 26';
            TableRelation = "Prepay Reason Code";
        }
        field(68; "Free office plurality 27"; Code[12])
        {
            Caption = 'Free office plurality 27';
            TableRelation = "Prepay Reason Code";
        }
        field(69; "Free office plurality 28"; Code[12])
        {
            Caption = 'Free office plurality 28';
            TableRelation = "Prepay Reason Code";
        }
        field(70; "Free office plurality 29"; Code[12])
        {
            Caption = 'Free office plurality 29';
            TableRelation = "Prepay Reason Code";
        }
        field(71; "Free office plurality 30"; Code[12])
        {
            Caption = 'Free office plurality 30';
            TableRelation = "Prepay Reason Code";
        }
        field(72; "Free office plurality 31"; Code[12])
        {
            Caption = 'Free office plurality 31';
            TableRelation = "Prepay Reason Code";
        }
        field(73; "Free office plurality 32"; Code[10])
        {
            Caption = 'Free office plurality 32';
            TableRelation = "Prepay Reason Code";
        }
        field(74; "Free office plurality 33"; Code[10])
        {
            Caption = 'Free office plurality 33';
            TableRelation = "Prepay Reason Code";
        }
        field(75; "Free office plurality 34"; Code[10])
        {
            Caption = 'Free office plurality 34';
            TableRelation = "Prepay Reason Code";
        }
        field(76; "Free office plurality 35"; Code[10])
        {
            Caption = 'Free office plurality 35';
            TableRelation = "Prepay Reason Code";
        }
        field(77; "Free office plurality 36"; Code[10])
        {
            Caption = 'Free office plurality 36';
            TableRelation = "Prepay Reason Code";
        }
        field(78; "Free office plurality 37"; Code[10])
        {
            Caption = 'Free office plurality 37';
            TableRelation = "Prepay Reason Code";
        }
        field(79; "Free office plurality 38"; Code[10])
        {
            Caption = 'Free office plurality 38';
            TableRelation = "Prepay Reason Code";
        }
        field(80; "Free office plurality 39"; Code[10])
        {
            Caption = 'Free office plurality 39';
            TableRelation = "Prepay Reason Code";
        }
        field(81; "Free office plurality 40"; Code[10])
        {
            Caption = 'Free office plurality 40';
            TableRelation = "Prepay Reason Code";
        }
        field(82; "Free office plurality 41"; Code[10])
        {
            Caption = 'Free office plurality 41';
            TableRelation = "Prepay Reason Code";
        }
        field(83; "Free office plurality 42"; Code[10])
        {
            Caption = 'Free office plurality 42';
            TableRelation = "Prepay Reason Code";
        }
        field(84; "Free office plurality 43"; Code[10])
        {
            Caption = 'Free office plurality 43';
            TableRelation = "Prepay Reason Code";
        }
        field(85; "Free office plurality 44"; Code[10])
        {
            Caption = 'Free office plurality 44';
            TableRelation = "Prepay Reason Code";
        }
        field(86; "Free office plurality 45"; Code[10])
        {
            Caption = 'Free office plurality 45';
            TableRelation = "Prepay Reason Code";
        }
        field(87; "Free office plurality 46"; Code[10])
        {
            Caption = 'Free office plurality 46';
            TableRelation = "Prepay Reason Code";
        }
        field(88; "Free office plurality 47"; Code[10])
        {
            Caption = 'Free office plurality 47';
            TableRelation = "Prepay Reason Code";
        }
        field(89; "Free office plurality 48"; Code[10])
        {
            Caption = 'Free office plurality 48';
            TableRelation = "Prepay Reason Code";
        }
        field(90; "Free office plurality 49"; Code[10])
        {
            Caption = 'Free office plurality 49';
            TableRelation = "Prepay Reason Code";
        }
        field(91; "Free office plurality 50"; Code[10])
        {
            Caption = 'Free office plurality 50';
            TableRelation = "Prepay Reason Code";
        }
        field(92; "Free office plurality 51"; Code[10])
        {
            Caption = 'Free office plurality 51';
            TableRelation = "Prepay Reason Code";
        }
        field(93; "Free office plurality 52"; Code[10])
        {
            Caption = 'Free office plurality 52';
            TableRelation = "Prepay Reason Code";
        }
        field(94; "Free office plurality 53"; Code[10])
        {
            Caption = 'Free office plurality 53';
            TableRelation = "Prepay Reason Code";
        }
        field(95; "Free office plurality 54"; Code[10])
        {
            Caption = 'Free office plurality 54';
            TableRelation = "Prepay Reason Code";
        }
        field(96; "Free office plurality 55"; Code[10])
        {
            Caption = 'Free office plurality 55';
            TableRelation = "Prepay Reason Code";
        }
        field(97; "Free office plurality 56"; Code[10])
        {
            Caption = 'Free office plurality 56';
            TableRelation = "Prepay Reason Code";
        }
        field(98; "Free office plurality 57"; Code[10])
        {
            Caption = 'Free office plurality 57';
            TableRelation = "Prepay Reason Code";
        }
        field(99; "Free office plurality 58"; Code[10])
        {
            Caption = 'Free office plurality 58';
            TableRelation = "Prepay Reason Code";
        }
        field(100; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(101; "Free office plurality 1 Type"; Option)
        {
            Caption = 'Free office plurality 1 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(102; "Free office plurality 2 Type"; Option)
        {
            Caption = 'Free office plurality 2 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(103; "Free office plurality 3 Type"; Option)
        {
            Caption = 'Free office plurality 3 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(104; "Free office plurality 4 Type"; Option)
        {
            Caption = 'Free office plurality 4 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(105; "Free office plurality 5 Type"; Option)
        {
            Caption = 'Free office plurality 5 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(106; "Free office plurality 6 Type"; Option)
        {
            Caption = 'Free office plurality 6 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(107; "Free office plurality 7 Type"; Option)
        {
            Caption = 'Free office plurality 7 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(108; "Free office plurality 8 Type"; Option)
        {
            Caption = 'Free office plurality 8 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(109; "Free office plurality 9 Type"; Option)
        {
            Caption = 'Free office plurality 9 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(110; "Free office plurality 10 Type"; Option)
        {
            Caption = 'Free office plurality 10 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(111; "Free office plurality 11 Type"; Option)
        {
            Caption = 'Free office plurality 11 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(112; "Free office plurality 12 Type"; Option)
        {
            Caption = 'Free office plurality 12 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(113; "Free office plurality 13 Type"; Option)
        {
            Caption = 'Free office plurality 13 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(114; "Free office plurality 14 Type"; Option)
        {
            Caption = 'Free office plurality 14 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(115; "Free office plurality 15 Type"; Option)
        {
            Caption = 'Free office plurality 15 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(116; "Free office plurality 16 Type"; Option)
        {
            Caption = 'Free office plurality 16 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(117; "Free office plurality 17 Type"; Option)
        {
            Caption = 'Free office plurality 17 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(118; "Free office plurality 18 Type"; Option)
        {
            Caption = 'Free office plurality 18 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(119; "Free office plurality 19 Type"; Option)
        {
            Caption = 'Free office plurality 19 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(120; "Free office plurality 20 Type"; Option)
        {
            Caption = 'Free office plurality 20 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(121; "Free office plurality 21 Type"; Option)
        {
            Caption = 'Free office plurality 21 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(122; "Free office plurality 22 Type"; Option)
        {
            Caption = 'Free office plurality 22 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(123; "Free office plurality 23 Type"; Option)
        {
            Caption = 'Free office plurality 23 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(124; "Free office plurality 24 Type"; Option)
        {
            Caption = 'Free office plurality 24 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(125; "Free office plurality 25 Type"; Option)
        {
            Caption = 'Free office plurality 25 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(126; "Free office plurality 26 Type"; Option)
        {
            Caption = 'Free office plurality 26 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(127; "Free office plurality 27 Type"; Option)
        {
            Caption = 'Free office plurality 27 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(128; "Free office plurality 28 Type"; Option)
        {
            Caption = 'Free office plurality 28 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(129; "Free office plurality 29 Type"; Option)
        {
            Caption = 'Free office plurality 29 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(130; "Free office plurality 30 Type"; Option)
        {
            Caption = 'Free office plurality 30 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(131; "Free office plurality 31 Type"; Option)
        {
            Caption = 'Free office plurality 31 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(132; "Free office plurality 32 Type"; Option)
        {
            Caption = 'Free office plurality 32 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(133; "Free office plurality 33 Type"; Option)
        {
            Caption = 'Free office plurality 33 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(134; "Free office plurality 34 Type"; Option)
        {
            Caption = 'Free office plurality 34 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(135; "Free office plurality 35 Type"; Option)
        {
            Caption = 'Free office plurality 35 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(136; "Free office plurality 36 Type"; Option)
        {
            Caption = 'Free office plurality 36 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(137; "Free office plurality 37 Type"; Option)
        {
            Caption = 'Free office plurality 37 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(138; "Free office plurality 38 Type"; Option)
        {
            Caption = 'Free office plurality 38 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(139; "Free office plurality 39 Type"; Option)
        {
            Caption = 'Free office plurality 39 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(140; "Free office plurality 40 Type"; Option)
        {
            Caption = 'Free office plurality 40 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(141; "Free office plurality 41 Type"; Option)
        {
            Caption = 'Free office plurality 41 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(142; "Free office plurality 42 Type"; Option)
        {
            Caption = 'Free office plurality 42 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(143; "Free office plurality 43 Type"; Option)
        {
            Caption = 'Free office plurality 43 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(144; "Free office plurality 44 Type"; Option)
        {
            Caption = 'Free office plurality 44 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(145; "Free office plurality 45 Type"; Option)
        {
            Caption = 'Free office plurality 45 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(146; "Free office plurality 46 Type"; Option)
        {
            Caption = 'Free office plurality 46 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(147; "Free office plurality 47 Type"; Option)
        {
            Caption = 'Free office plurality 47 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(148; "Free office plurality 48 Type"; Option)
        {
            Caption = 'Free office plurality 48 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(149; "Free office plurality 49 Type"; Option)
        {
            Caption = 'Free office plurality 49 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(150; "Free office plurality 50 Type"; Option)
        {
            Caption = 'Free office plurality 50 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(151; "Free office plurality 51 Type"; Option)
        {
            Caption = 'Free office plurality 51 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(152; "Free office plurality 52 Type"; Option)
        {
            Caption = 'Free office plurality 52 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(153; "Free office plurality 53 Type"; Option)
        {
            Caption = 'Free office plurality 50 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(154; "Free office plurality 54 Type"; Option)
        {
            Caption = 'Free office plurality 54 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(155; "Free office plurality 55 Type"; Option)
        {
            Caption = 'Free office plurality 55 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(156; "Free office plurality 56 Type"; Option)
        {
            Caption = 'Free office plurality 56 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(157; "Free office plurality 57 Type"; Option)
        {
            Caption = 'Free office plurality 57 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(158; "Free office plurality 58 Type"; Option)
        {
            Caption = 'Free office plurality 58 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(159; "Free office plurality 59 Type"; Option)
        {
            Caption = 'Free office plurality 59 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(160; "Free office plurality 60 Type"; Option)
        {
            Caption = 'Free office plurality 60 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(161; "Free office plurality 61 Type"; Option)
        {
            Caption = 'Free office plurality 61 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(162; "Free office plurality 62 Type"; Option)
        {
            Caption = 'Free office plurality 62 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(163; "Free office plurality 63 Type"; Option)
        {
            Caption = 'Free office plurality 63 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(164; "Free office plurality 64 Type"; Option)
        {
            Caption = 'Free office plurality 64 Type';
            OptionCaption = 'Quantity,Amount';
            OptionMembers = Quantity,Amount;
        }
        field(200; "Free office plurality 59"; Code[10])
        {
            Caption = 'Free office plurality 59';
            TableRelation = "Prepay Reason Code";
        }
        field(201; "Free office plurality 60"; Code[10])
        {
            Caption = 'Free office plurality 60';
            TableRelation = "Prepay Reason Code";
        }
        field(202; "Free office plurality 61"; Code[10])
        {
            Caption = 'Free office plurality 61';
            TableRelation = "Prepay Reason Code";
        }
        field(203; "Free office plurality 62"; Code[10])
        {
            Caption = 'Free office plurality 62';
            TableRelation = "Prepay Reason Code";
        }
        field(204; "Free office plurality 63"; Code[10])
        {
            Caption = 'Free office plurality 63';
            TableRelation = "Prepay Reason Code";
        }
        field(205; "Free office plurality 64"; Code[10])
        {
            Caption = 'Free office plurality 64';
            TableRelation = "Prepay Reason Code";
        }
        field(206; "VM File Name"; Text[250])
        {
            Caption = 'VM File Name';

            trigger OnValidate()
            begin
                //#7659\\
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

