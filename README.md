Synergy Inventory Management Interface (IMI)
============================================

An interface where administrator can manage products easily on one page and quickly perform the common products actions.


Installation
------------

Install synergy_inventory_management from git:

    gem 'synergy_inventory_management', :git => 'git@github.com:secoint/synergy_inventory_management.git'

Bundle up with:

    bundle install
    
Run the rake task that adds the assets to your project:

    rails g synergy_inventory_management:install
       
Now you should be able to boot up your server with:

    rails s  
    
Enjoy!


Compatibility
-------------

Current version (0.2) compatible with Spree/Synergy 0.60.


Usage
-----

You can access the interface in Products -> Inventory management menu.

From the left there is a tree of taxonomies, where admin can manage nodes just like he does it in /admin/taxonomies now (create, move, rename etc.). After each taxon there is a number of products, having this taxon. By clicking on a taxon or taxonomy admin can see products having taxons in a selected node.
 
Products are shown in Products list. Products list contains the following columns:

 * Selecting checkbox (helps to select a set of products for group processing).

 * SKU

 * Product name (also a link to edit product)

 * Main price

 * Indicator if a product has image

 * Quick actions 

Products list have pagination and "products per page" selector (10/50/100/All).

Each product has the following quick actions (from left to right):

 * Indicator if the product is shown in a shop. If an indicator is dark, the product is hidden. By clicking on a dark indicator product becomes available from now. Light indicator tells that the product is active; admin can hide the product from now by clicking it.

 * Preview the product on site (opens in a new tab).

 * Edit product.
 
 * Clone product.

 * Delete product.

Above the Products list there a button "New product in this category". This button opens "new product" dialog with pre-defined taxon (current selected taxon).

Quick group products processing controls from the right perform just the most common actions with selected products:

 * Publish from (select date).

 * Quick hide from now.

 * Add a taxon to selected products (select taxon from combo-box).

 * Delete selected products.


Any questions?
--------------

Feel free to ask: synergy@secoint.ru

Russian-speaking community: http://groups.google.com/group/synergy-user
