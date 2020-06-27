# Microsoft License types

This is valid for Office/Windows:

- OEM: for consumers (not big companies), who buy the
  license for one computer and they do not want to move it to new
  computers.

- Retail: for consumers, who wants to have a license independently
  from any computer, so they will always have the right to use it on
  exactly one computer (but that one computer can change).

- Volume: for companies, where hundreds/thousands of windows copies
  are used and licensed.

NB: as discussed in the [README.md](README.md), in the EU, OEM is
basically equivalent to Retail legally.  At least to my knowledge, but
I'm not a lawyer...

# TLDR on how to get a Retail/OEM key and not get scammed

1. Choose wisely
  - pay for seller that explicitly says OEM/Retail
  - or use a shop from allkeyshop.com (e.g. https://www.gamers-outlet.net/)
  - or use a real german shop with an address (e.g. mysoftware.de, imomax.de, myoem.de), usually more expensive
  - myoem.de is very good, you can see if you are buying online/telephone activate, oem/retail, etc.
2. Once you get the key, search for the two first segments on Google (e.g. "3gr2y wnfqy" was my fake key)
3. If all looks good, use the VAMT tool before activation (or `slmgr /dli` after activation) to check the key
4. If it really is a retail/oem, then link it to your Microsoft account, so no one can sell it to someone else

Note: I'm not affiliated with any of the shops referenced.

# Volume license types: MAK vs KMS

For big companies, Microsoft sells Office/Windows products with volume
licensing, so that the sysadmins don't have to handle thousands of
license keys and enter them by hand.

Simple solution: MAK (multi activation keys).  These keys can be used
to activate computers online many times.  They have a counter on the
server, and every time you activate a new hardware with them, the
counter decreases by 1.  When the counter reaches 0, then you can't
use the key anymore.

Usually Microsoft gives a bigger MAK key than what the company paid
for, so the sysadmin can do some reinstall/hardware maintenance,
whatever.

This is obviously a very simple and easy way to handle things, but
very susceptible for fraud, because if the key gets out, then other
people can also use it and there is not much control in the hand of
the real customer.

More complicated solution: KMS, the organization has to run a
licensing server in its own active directory infrastructure and
licenses are only received from it by the computers for a period
(typically months, or 1-2 years).  It is assumed that the computers
connect to the company network once in a while, so this is not a
problem.  In exchange, the admins have a perfect view of how many
licenses are used in the company at any given time, and the licenses
are not easy to steal or sell, because activation requires access to
the company network, which is protected by VPN and requires AD login.

# Ebay: are these really used Retail/OEM licenses or scammy volume licenses?

Ebay $5 licenses are great.  They even seem legal, because most
sellers tell you, that the license you receive is an old, unused
Retail license (or in case of EU, maybe OEM).

But, now that we know about Volume MAK licensing, maybe this whole
"OEM law in EU" is a charade around a big fraud business: sellling
volume MAK licenses for noobs, who can't tell the difference!

Let's investigate.

## Checking your current Windows installation

Start a powershell as administrator and run `slmgr /dli`.

Channel gives you `RETAIL`/`OEM`/`VOLUME_MAK`/`VOLUME_KMSCLIENT` info;
partial product key helps you identify your license if you have many
machines and bought more and forgot which machine has which key.

(Note: `slmgr /?` gives you a lot of other interesting commands to
experiment with, if you are interested.)

## Checking licenses without activation (and checking Office licenses)

Microsft VAMT 3.1 is an amazing tool to check product key info easily.

Here are the instructions:
https://www.terminalworks.com/blog/post/2015/12/13/volume-activation-management-tool-3-1-implementing-and-activating

You need a windows to run this tool, but otherwise every component is
free, you don't have to pay.  Please pay attention to the detailed
installation and usage instructions on the provided link.

If you have a volume key (MAK), this tool will even give you the
number of remaining activations on that key.

## Ebay scam no1: public key sold for money

Once I was sold a Windows 10 Pro key that when googled for was simply
out on the internet.  This obviously didn't work/activate at all.
This is outright scam, so handle it as you wish.

I reported to ebay, but even after proving that this has nothing to do
with used licenses, and it's just a scam, the ebay representative
refused to do anything about it, telling me to report it to my credit
card company.  Make sure you remember: ebay has zero customer
protection when you buy non-physical goods.

Since it was GBP 1.69, and the credit card company in question was
Revolut (so dealing with customer support would have been a couple of
days of stress), I decided to just let it go.

Lesson learnt:
  - really cheap sellers (under $4-6) are most probably real scammers,
  - if somebody doesn't have at least 100-200 positive reviews on keys, then you shouldn't buy at all,
  - if somebody has any negative review that says the key is on the internet, then do not buy.

## Ebay scam no2: selling volume MAK key instead of retail/oem keys

This Windows 10 Pro was sold for $5, so in the same range that a
normal, real retail/oem used seller sells.  I guess this was a
sysadmin who had a couple of thousands of activations left on his MAK
key and decided the salary was not enough.

It's up to you to decide if this is a scam you are willing to accept or not.

Disadvantages:
  - might not be legal (but I am not a lawyer, and I guess it's a used
    license in some sense),
  - Microsoft might disable it after a couple of months or years
    (although reddit says they usually don't disable activated stuff),
  - you might not like the ethics of it: this is not like buying a
    second-hand software, but simply using a license from Microsoft
    that was not intended this way.

Advantages:
  - if somebody sells you a MAK key and the VAMT tool says that is has
    a 1234 activations left, then you can in theory use this on 1234
    more machines, before others use it (although this might be
    completely illegal, depending on the laws of your country).

Compared to the other scam, this scam is very easy to handle on ebay.
I just mailed the guy, saying that he promised a OEM/Retail key, and
instead he sold a Volume scam.  I explained that ebay customer service
is abysmal and microsoft is hard to contact about fraud, so I would
rather just get my money back quickly than trying to going through any
kind of call center of microsoft.  I had my refund on my account in 5
minutes without any more communication from him.

Then I used this refund to buy a proper, used retail license from an
another seller.

## Ebay statistics, how scammy ebay is?

As a test several licenses were bought from ebay, without paying much
attention at the details (assuming they are all legal, used licenses
sold for cheap), here are the results:

 - 1 Windows Pro total scam: key is found by google on the internet
 - 4 MAK keys: 1x Windows 8 Pro, 2x Windows 10 Pro, 1x Office 16 Pro
 - 4 OEM keys: 2x Windows 10 Pro, 1x Windows 8.1 Home, 1x Windows 7 Pro
 - 4 Retail: 1x Windows 10 Pro, 3x Office 16 Pro

2x Office19 Pro Retail keys activated successfully, but since VAMT
doesn't support Office19 yet, we can't be absolutely sure about their
status.

The installations with MAK keys have not been deactivted so far, they
might even be legal: I'm not a lawyer, I don't know if companies can
sell used software or not.

But if you want to stay OEM/Retail, then it looks like that it's
better to pay attention at purchase time on ebay.  There are sellers
who explicitly promise you that this is a used retail/oem key with a
used machine (they might even send the broken machine if you ask).
There are also sellers, who provide their real business address in
Germany and issue you a VAT invoice as proof.  These sellers usually
sell for $10-15, instead of $5, but I think the probability of
receiving a genuine consumer key (not MAK) is much bigger with them.
