(function(root) {
	'use strict';

	function clr(root)
	{
		var e;
		if (null !== (e = find(root))) 
			while (e.firstChild)
				e.removeChild(e.firstChild);
		return(e);
	}

	function repl(root, text)
	{
		var e;
		if (null !== (e = clr(root))) 
			e.appendChild(document.createTextNode(text));
		return(e);
	}

	function showcl(root, name)
	{
		var list, i, sz, e;
		if (null === (e = find(root)))
			return;
		list = e.getElementsByClassName(name);
		for (i = 0, sz = list.length; i < sz; i++)
			show(list[i]);
	}

	function hidecl(root, name)
	{
		var list, i, sz, e;
		if (null === (e = find(root)))
			return;
		list = e.getElementsByClassName(name);
		for (i = 0, sz = list.length; i < sz; i++)
			hide(list[i]);
	}

	function replcl(root, name, text)
	{
		var list, i, sz, e;
		if (null === (e = find(root)))
			return;
		list = e.getElementsByClassName(name);
		for (i = 0, sz = list.length; i < sz; i++)
			repl(list[i], text);
	}

	function find(root)
	{
		return((typeof root !== 'string') ? 
			root : document.getElementById(root));
	}

	function show(root)
	{
		var e;
		if (null === (e = find(root)))
			return(null);
		if (e.classList.contains('hide'))
			e.classList.remove('hide');
		return(e);
	}

	function hide(root)
	{
		var e;
		if (null === (e = find(root)))
			return(null);
		if ( ! e.classList.contains('hide'))
			e.classList.add('hide');
		return(e);
	}

	function attr(root, key, val)
	{
		var e;
		if (null !== (e = find(root)))
			e.setAttribute(key, val);
		return(e);
	}

	function attrcl(root, name, key, val)
	{
		var list, i, sz, e;
		if (null === (e = find(root)))
			return;
		list = e.getElementsByClassName(name);
		for (i = 0, sz = list.length; i < sz; i++)
			attr(list[i], key, val);
	}

	function auditAccessfromFill(data, root)
	{
		var obj, list, i;
		if (null === (obj = auditFunctionGet(data.function)))
			return;
		replcl(root, 'audit-data-accessfrom-function', data.function);
		list = root.getElementsByClassName('audit-accessfrom-more');
		for (i = 0; i < list.length; i++)
			list[i].onclick = function(d, o) {
				return function() {
					var e = show('kwbp-aside');
					hidecl(e, 'aside-types');
					fillAccessfrom(show('kwbp-aside-function-accessfrom'), d, o);
				};
			}(data, obj);
		replcl(root, 'audit-data-accessfrom-path', data.paths.length);
		if (data.exporting) 
			showcl(root, 'audit-data-accessfrom-exporting');
		else
			hidecl(root, 'audit-data-accessfrom-exporting');
	}

	function fillDataField(root, strct, field, exportable)
	{
		var list, i, obj;
		if (null === (obj = auditFieldGet(strct, field)))
			return;
		replcl(root, 'audit-data-field-fullname', strct + '.' + field);
		replcl(root, 'audit-data-field-name', field);
		if (null !== obj.doc) {
			replcl(root, 'audit-data-field-doc', obj.doc);
			showcl(root, 'audit-data-field-doc');
			hidecl(root, 'audit-data-field-nodoc');
		} else {
			hidecl(root, 'audit-data-field-doc');
			showcl(root, 'audit-data-field-nodoc');
		}
		if (obj.export && exportable) {
			hidecl(root, 'audit-data-field-noexport');
			showcl(root, 'audit-data-field-export');
		} else {
			showcl(root, 'audit-data-field-noexport');
			hidecl(root, 'audit-data-field-export');
		}
		list = root.getElementsByClassName('audit-data-field-more');
		for (i = 0; i < list.length; i++)
			list[i].onclick = function(s, f) {
				return function() {
					var e = show('kwbp-aside');
					hidecl(e, 'aside-types');
					fillDataField(show('kwbp-aside-data-field-data'), 
						s, f, exportable);
				};
			}(strct, field);
	}

	function auditFunctionGet(name)
	{
		var obj = null;
		if ( ! (name in audit.functions) ||
		    null === (obj = audit.functions[name]))
			console.log('cannot find function: ' + name);
		return(obj);
	}
	
	function auditFieldGet(strct, field)
	{
		var obj = null, fullname = strct + '.' + field;
		if ( ! (fullname in audit.fields) ||
		    null === (obj = audit.fields[fullname])) 
			console.log('cannot find data field: ' + fullname);
		return(obj);
	}

	function fillShowMore(root, type, name, func)
	{
		var list, i;

		list = root.getElementsByClassName('audit-' + type + '-more');
		for (i = 0; i < list.length; i++)
			list[i].onclick = function(n, t, f) {
				return function() {
					var e = show('kwbp-aside');
					hidecl(e, 'aside-types');
					f(show('kwbp-aside-function-' + t), n);
				};
			}(name, type, func);
	}
	function fillUpdate(root, name)
	{
		var obj;
		if (null === (obj = auditFunctionGet(name)))
			return;
		replcl(root, 'audit-update-function', name);
		if (null !== obj.doc) {
			replcl(root, 'audit-update-doc', obj.doc);
			showcl(root, 'audit-update-doc');
			hidecl(root, 'audit-update-nodoc');
		} else {
			hidecl(root, 'audit-update-doc');
			showcl(root, 'audit-update-nodoc');
		}
		fillShowMore(root, 'update', name, fillUpdate);
	}

	function fillAccessfrom(root, data, obj)
	{
		var row, col, list, i, j, k;

		replcl(root, 'audit-accessfrom-function', data.function);
		if (null !== obj.doc) {
			replcl(root, 'audit-accessfrom-doc', obj.doc);
			showcl(root, 'audit-accessfrom-doc');
			hidecl(root, 'audit-accessfrom-nodoc');
		} else {
			hidecl(root, 'audit-accessfrom-doc');
			showcl(root, 'audit-accessfrom-nodoc');
		}
		list = root.getElementsByClassName('audit-accessfrom-paths');
		for (i = 0; i < list.length; i++) {
			clr(list[i]);
			for (j = 0; j < data.paths.length; j++) {
				row = document.createElement('li');
				list[i].appendChild(row);
				for (k = 0; k < data.paths[j].path.length; k++) {
					col = document.createElement('span');
					col.className = 'path';
					row.appendChild(col);
					repl(col, data.paths[j].path[k]);
				}
				if (0 === data.paths[j].path.length) {
					col = document.createElement('span');
					row.appendChild(col);
					repl(col, '(self)');
				} else if (data.paths[j].exporting) {
					col = document.createElement('span');
					row.appendChild(col);
					repl(col, ' (exporting)'); 
				} 
			}
		}
	}

	function fillInsert(root, name)
	{
		var obj;
		if (null === (obj = auditFunctionGet(name)))
			return;
		replcl(root, 'audit-insert-function', name);
		fillShowMore(root, 'insert', name, fillInsert);
	}

	function fillDelete(root, name)
	{
		var obj;
		if (null === (obj = auditFunctionGet(name)))
			return;
		replcl(root, 'audit-delete-function', name);
		if (null !== obj.doc) {
			replcl(root, 'audit-delete-doc', obj.doc);
			showcl(root, 'audit-delete-doc');
			hidecl(root, 'audit-delete-nodoc');
		} else {
			hidecl(root, 'audit-delete-doc');
			showcl(root, 'audit-delete-nodoc');
		}
		fillShowMore(root, 'delete', name, fillDelete);
	}

	function fillSearch(root, name)
	{
		var obj;
		if (null === (obj = auditFunctionGet(name)))
			return;
		replcl(root, 'audit-search-function', name);
		if (null !== obj.doc) {
			replcl(root, 'audit-search-doc', obj.doc);
			showcl(root, 'audit-search-doc');
			hidecl(root, 'audit-search-nodoc');
		} else {
			hidecl(root, 'audit-search-doc');
			showcl(root, 'audit-search-nodoc');
		}
		fillShowMore(root, 'search', name, fillSearch);
	}

	function fillList(root, name)
	{
		var obj;
		if (null === (obj = auditFunctionGet(name)))
			return;
		replcl(root, 'audit-list-function', name);
		if (null !== obj.doc) {
			replcl(root, 'audit-list-doc', obj.doc);
			showcl(root, 'audit-list-doc');
			hidecl(root, 'audit-list-nodoc');
		} else {
			hidecl(root, 'audit-list-doc');
			showcl(root, 'audit-list-nodoc');
		}
		fillShowMore(root, 'list', name, fillList);
	}

	function fillIterate(root, name)
	{
		var obj;
		if (null === (obj = auditFunctionGet(name)))
			return;
		replcl(root, 'audit-iterate-function', name);
		if (null !== obj.doc) {
			replcl(root, 'audit-iterate-doc', obj.doc);
			showcl(root, 'audit-iterate-doc');
			hidecl(root, 'audit-iterate-nodoc');
		} else {
			hidecl(root, 'audit-iterate-doc');
			showcl(root, 'audit-iterate-nodoc');
		}
		fillShowMore(root, 'iterate', name, fillIterate);
	}

	function fill(root, vec, name, func)
	{
		var list, i, j, sub, clone;

		vec.sort(function(a, b) {
			return(a.localeCompare(b));
		});

		if (vec.length > 0) {
			hidecl(root, 'audit-no' + name);
			showcl(root, 'audit-' + name + '-list');
			list = root.getElementsByClassName
				('audit-' + name + '-list');
			for (i = 0; i < list.length; i++) {
				sub = list[i].children[0];
				clr(list[i]);
				for (j = 0; j < vec.length; j++) {
					clone = sub.cloneNode(true);
					list[i].appendChild(clone);
					func(clone, vec[j]);
				}
			}
		} else {
			hidecl(root, 'audit-' + name + '-list');
			showcl(root, 'audit-no' + name);
		}
	}

	function fillVec(vec, name, func)
	{
		var e, sub, i, clone, list;

		vec.sort(function(a, b) {
			return(a.localeCompare(b));
		});

		list = document.getElementsByClassName
			('audit-function-' + name + '-count');
		for (i = 0; i < list.length; i++)
			repl(list[i], vec.length);

		e = find('kwbp-audit-' + name + '-list');
		sub = e.children[0];
		clr(e);
		for (i = 0; i < vec.length; i++) {
			clone = sub.cloneNode(true);
			e.appendChild(clone);
			func(clone, vec[i]);
		}

		e = find('kwbp-audit-byoperation-' + name);

		if (0 === vec.length) {
			if (null !== e &&
			    ! e.classList.contains('noop'))
				e.classList.add('noop');
			hide('kwbp-audit-' + name + '-list');
			show('kwbp-audit-no' + name);
		} else {
			if (null !== e)
				e.classList.remove('noop');
			show('kwbp-audit-' + name + '-list');
			hide('kwbp-audit-no' + name);
		}
	}

	function auditFill(audit, root, num)
	{
		var e, sub, i, j, clone, list, vec, exp,
			nvec, obj, noexport, pct, ins, paths;

		replcl(root, 'audit-name', audit.name);
		attrcl(root, 'audit-label', 'for', audit.name);
		attrcl(root, 'audit-view', 'id', audit.name);
		attrcl(root, 'audit-view', 'checked', false);
		attrcl(root, 'audit-view', 'value', num);

		pct = ins = 0;

		/* 
		 * If found, fill in data field and access members.
		 * This is defined IFF the structure is reachable from
		 * any other structure for queries.
		 * If 'data' isn't defined, 'accessfrom' will also be
		 * empty (by definition).
		 */

		if ('data' in audit.access) {
			ins = 1;
			hidecl(root, 'audit-nodata');
			showcl(root, 'audit-data');
			showcl(root, 'audit-accessfrom');
			
			/* Pre-sort by alpha. */

			audit.access.data.sort(function(a, b) {
				return(a.localeCompare(b));
			});
			audit.access.accessfrom.sort(function(a, b) {
				return(a.function.localeCompare(b.function));
			});

			vec = audit.access.data;
			list = root.getElementsByClassName
				('audit-data-list');

			/*
			 * Individual fields may have noexport marked on
			 * them, so accumulate the number now.
			 * We'll override this with whether the whole
			 * structure is marked as not exported, however.
			 */

			for (noexport = j = 0; j < vec.length; j++) {
				obj = auditFieldGet(audit.name, vec[j]);
				if (null !== obj)
					noexport += obj.export ? 0 : 1;
			}

			/*
			 * List all of the fields we have accessable
			 * and/or exportable.
			 * Allow our structure's exportability to
			 * influence how we document the field.
			 */

			for (i = 0; i < list.length; i++) {
				sub = list[i].children[0];
				clr(list[i]);
				for (j = 0; j < vec.length; j++) {
					clone = sub.cloneNode(true);
					list[i].appendChild(clone);
					fillDataField(clone, 
						audit.name, vec[j], 
						audit.access.exportable);
				}
			}

			/* 
			 * Compute our exportability.
			 * This only matters if the structure is
			 * exportable as well.
			 */

			if (audit.access.exportable)
				pct = Math.round((1.0 - 
					(noexport / vec.length)) * 100);

			/*
			 * These are all of the functions that lead to
			 * the current structure.
			 * A function may have multiple ways of getting
			 * to the same place, so begin by collecting
			 * them all here, then we'll print them.
			 * Keep track of exportability.
			 */

			vec = audit.access.accessfrom;
			nvec = [];
			for (i = 0; i < vec.length; ) {
				obj = {};
				obj.function = vec[i].function;
				obj.paths = [];
				obj.paths.push(vec[i]);
				exp = vec[i].exporting ? 1 : 0;
				for (j = i + 1; j < vec.length; j++) {
					if (vec[j].function !== vec[i].function)
						break;
					obj.paths.push(vec[j]);
					exp += vec[j].exporting ? 1 : 0;
				}
				obj.exporting = (exp > 0);
				nvec.push(obj);
				i = j;
			}

			/* Now print our accessed-from functions. */

			list = root.getElementsByClassName
				('audit-accessfrom-list');
			for (i = 0; i < list.length; i++) {
				sub = list[i].children[0];
				clr(list[i]);
				for (j = 0; j < nvec.length; j++) {
					clone = sub.cloneNode(true);
					list[i].appendChild(clone);
					auditAccessfromFill(nvec[j], clone);
				}
			}
		} else {
			hidecl(root, 'audit-data');
			hidecl(root, 'audit-accessfrom');
			showcl(root, 'audit-nodata');
		}

		/* Fill insert function (if applicable). */

		if (null !== audit.access.insert) {
			showcl(root, 'audit-insert');
			hidecl(root, 'audit-noinsert');
			fillInsert(root, audit.access.insert);
			ins++;
		} else {
			hidecl(root, 'audit-insert');
			showcl(root, 'audit-noinsert');
		}

		/* Now count up our totals. */
		
		replcl(root, 'audit-data-count', pct + '%');
		replcl(root, 'audit-queries-count', 
			audit.access.searches.length +
			audit.access.lists.length +
			audit.access.iterates.length);
		replcl(root, 'audit-updates-count', 
			audit.access.updates.length);
		replcl(root, 'audit-deletes-count', 
			audit.access.deletes.length);

		if (0 === pct + ins + 
		    audit.access.deletes.length +
		    audit.access.updates.length +
		    audit.access.searches.length +
		    audit.access.lists.length +
		    audit.access.iterates.length) {
			if ( ! root.classList.contains('noop'))
				root.classList.add('noop');
		} else
			root.classList.remove('noop');

		/* Fill other functions. */

		fill(root, audit.access.searches, 'searches', fillSearch);
		fill(root, audit.access.iterates, 'iterates', fillIterate);
		fill(root, audit.access.lists, 'lists', fillList);
		fill(root, audit.access.updates, 'updates', fillUpdate);
		fill(root, audit.access.deletes, 'deletes', fillDelete);
	}

	function init() 
	{
		var e, sub, i, j, clone, vec, list, ac;

		if (typeof audit !== 'object' || null === audit) {
			hide('kwbp-parsing');
			show('kwbp-parseerr');
			return;
		}

		ac = audit.access;
		
		/* Initialise page view for consistency. */

		if (null !== (e = find('kwbp-aside-close')))
			e.onclick = function() {
				hide('kwbp-aside');
			};

		repl('kwbp-audit-role', audit.role);
		list = document.getElementsByClassName
			('audit-toplevel-view');
		for (i = 0; i < list.length; i++)
			list[i].checked = true;

		if (null !== audit.doc) {
			show('kwbp-audit-role-doc');
			hide('kwbp-audit-role-nodoc');
			repl('kwbp-audit-role-doc', audit.doc);
		} else {
			hide('kwbp-audit-role-doc');
			show('kwbp-audit-role-nodoc');
		}

		/* Start with per-structure audit. */

		ac.sort(function(a, b) {
			return(a.name.localeCompare(b.name));
		});

		e = find('kwbp-audit-access-list');
		sub = e.children[0];
		clr(e);
		for (i = 0; i < ac.length; i++) {
			clone = sub.cloneNode(true);
			e.appendChild(clone);
			auditFill(ac[i], clone, i + 1);
		}

		/* Now fill for collected operations. */

		for (vec = [], i = 0; i < ac.length; i++)
			if (null !== ac[i].access.insert)
				vec.push(ac[i].access.insert);
		fillVec(vec, 'inserts', fillInsert);

		for (vec = [], i = 0; i < ac.length; i++)
			for (j = 0; j < ac[i].access.deletes.length; j++)
				vec.push(ac[i].access.deletes[j]);
		fillVec(vec, 'deletes', fillDelete);

		for (vec = [], i = 0; i < ac.length; i++)
			for (j = 0; j < ac[i].access.updates.length; j++)
				vec.push(ac[i].access.updates[j]);
		fillVec(vec, 'updates', fillUpdate);

		for (vec = [], i = 0; i < ac.length; i++)
			for (j = 0; j < ac[i].access.searches.length; j++)
				vec.push(ac[i].access.searches[j]);
		fillVec(vec, 'searches', fillSearch);

		for (vec = [], i = 0; i < ac.length; i++)
			for (j = 0; j < ac[i].access.iterates.length; j++)
				vec.push(ac[i].access.iterates[j]);
		fillVec(vec, 'iterates', fillIterate);

		for (vec = [], i = 0; i < ac.length; i++)
			for (j = 0; j < ac[i].access.lists.length; j++)
				vec.push(ac[i].access.lists[j]);
		fillVec(vec, 'lists', fillList);

		show('kwbp-parsed');
		hide('kwbp-parsing');
		hide('kwbp-parseerr');
	}

	root.init = init;
})(this);

window.addEventListener('load', init);
