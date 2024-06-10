import { Component } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { CommonModule } from '@angular/common';

export interface Token {
  index: number;
  address: string;
  name: string;
  symbol: string;
  supply: string;
  balance: string;
  owner: string;
  isOwner: boolean;
}

const ELEMENT_DATA: Token[] = [
  {
    index: 0,
    address: '0xCFe3DB42943d5B15a82442f164F345aD25b50986',
    name: 'Gold Coin',
    symbol: 'GC',
    supply: '1000',
    balance: '1',
    owner: '0x583727c3f2B3cfF4Cc0FFAc35ADB522436168929',
    isOwner: false
  },
  {
    index: 1,
    address: '0xB0f81b5d2bFC58a18008265C935eF28B4Dbee935',
    name: 'Silver Coin',
    symbol: 'SC',
    supply: '10000',
    balance: '15',
    owner: '0x583727c3f2B3cfF4Cc0FFAc35ADB522436168929',
    isOwner: false
  },
  {
    index: 2,
    address: '0x21F14398b3bb8146e3D36cB7F100E2103D2eBe01',
    name: 'Paper Coin',
    symbol: 'PC',
    supply: '1000000',
    balance: '800000',
    owner: '0xF3Dc9F11CaA21f122A667c28E54aA71274411784',
    isOwner: true
  }
];

@Component({
  selector: 'app-token-list',
  standalone: true,
  imports: [
    CommonModule,
    MaterialDesignModule
  ],
  templateUrl: './token-list.component.html',
  styleUrl: './token-list.component.scss'
})
export class TokenListComponent {
  tokenColumns: string[] = [
    'symbol', 'supply', 'balance', 'mint', 'owner'
  ];
  tokenList = ELEMENT_DATA;
}
