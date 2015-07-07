microspheres
------------
analysis of the microsphere dark field

run locally
------------
`middleman server`

git hook to push the compiled version to gh-pages
-------------------------------------------------
```
ln -s ../../pre-push .git/hooks/pre-push 
```

setup subtree remotes
-------------------------------------------------
```
git remote add enucatl-d3.base-chart git@github.com:Enucatl/d3.base-chart.git
git remote add enucatl-d3.axes git@github.com:Enucatl/d3.axes.git
git remote add enucatl-d3.barchart git@github.com:Enucatl/d3.barchart.git
git remote add enucatl-d3.colorbar git@github.com:Enucatl/d3.colorbar.git
git remote add enucatl-d3.errorbar git@github.com:Enucatl/d3.errorbar.git
git remote add enucatl-d3.image git@github.com:Enucatl/d3.image.git
git remote add enucatl-d3.line git@github.com:Enucatl/d3.line.git
git remote add enucatl-d3.scatter git@github.com:Enucatl/d3.scatter.git
```
